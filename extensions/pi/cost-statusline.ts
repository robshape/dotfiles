/**
 * Cost Statusline
 *
 * Shows, in the footer status line:
 *   turn $0.0010 · session $0.0432 · $13.53 left
 *   turn $0.0000 (cached) · session $0.0432 · $13.53 left
 *
 * - "turn"    is what the most recent prompt cost, across every model call the
 *             prompt triggered (including tool-use round trips). When every
 *             call in the prompt was served from a response cache, the provider
 *             reports zero usage, so we tag it "(cached)" to make clear the
 *             $0.0000 is genuinely free rather than untracked.
 * - "session" is the running total for this session.
 * - "$x left" is the OpenRouter account balance, fetched from the credits API.
 *             Only shown when the active provider is OpenRouter.
 *
 * How cost is found, in order:
 *   1. Some OpenAI-compatible providers (OpenRouter and friends) report the
 *      real charge on the final stream chunk as `usage.cost`. We capture that
 *      before pi normalizes usage into its own shape.
 *   2. Otherwise, we fall back to pi's own number
 *      (`AssistantMessage.usage.cost.total`), which pi prices from its model
 *      registry. For models pi has no pricing for, that is simply $0.
 */

import { readStoredCredential, type ExtensionAPI } from "@earendil-works/pi-coding-agent";
import type { AssistantMessage } from "@earendil-works/pi-ai";

const STATUS_KEY = "cost";
const ENTRY_TYPE = "cost";
const OPENROUTER_CREDITS_URL = "https://openrouter.ai/api/v1/credits";

/** One settled prompt's real cost, stored branch-scoped in the session. */
interface CostEntry {
	cost: number;
	cached?: boolean;
}

/** Real usage captured from a provider's raw stream, awaiting its message. */
interface RawUsage {
	totalTokens?: number;
	cost: number;
}

/** Account balance from the credits API. */
interface Balance {
	remaining: number;
	total: number;
}

let sessionCost = 0;
let lastPromptCost = 0;
let promptCost = 0;
// Assistant messages in the current prompt; > 0 means the prompt made a call.
let promptCalls = 0;
let rawUsage: RawUsage | undefined;
let balance: Balance | undefined;
let fetching = false;
// True once every model call in the current prompt was a cache hit; undefined
// until we have seen a response. A prompt whose calls were all cached costs $0.
let promptCacheHit: boolean | undefined;
let lastPromptCached = false;
// Last text pushed to setStatus, to skip redundant renders (see render()).
let lastStatus: string | undefined;
// False once the session is torn down; guards async work that outlives it.
let active = true;

/** OpenRouter key: environment first, then stored credential. */
function openRouterKey(): string | undefined {
	if (process.env.OPENROUTER_API_KEY) return process.env.OPENROUTER_API_KEY;
	const credential = readStoredCredential("openrouter");
	return credential?.type === "api_key" ? credential.key : undefined;
}

/** Dollars with enough precision to keep sub-cent costs visible. */
function usd(value: number, decimals?: number): string {
	if (!Number.isFinite(value)) return "$—";
	const magnitude = Math.abs(value);
	const places = decimals ?? (magnitude < 1 ? 4 : 2);
	return `$${value.toFixed(places)}`;
}

type Ctx = Parameters<Parameters<ExtensionAPI["on"]>[1]>[1];

function render(ctx: Ctx): void {
	if (!active || !ctx.hasUI) return;
	const theme = ctx.ui.theme;
	const dim = (text: string) => theme.fg("dim", text);

	// A cached prompt costs nothing; say so rather than looking like a failure.
	const cacheTag = lastPromptCached && lastPromptCost === 0 ? dim(" (cached)") : "";
	const parts = [
		`${dim("turn")} ${theme.fg("accent", usd(lastPromptCost))}${cacheTag}`,
		`${dim("session")} ${theme.fg("accent", usd(sessionCost))}`,
	];

	if (balance) {
		const exhausted = balance.remaining <= 0;
		const value = theme.fg(exhausted ? "error" : "success", `$${balance.remaining.toFixed(2)}`);
		parts.push(`${value}${dim(` left`)}`);
	}

	// setStatus triggers a render on every call, even when the text is unchanged,
	// and repeated identical frames can be pinned into scrollback. Skip no-ops.
	const text = parts.join(dim(" · "));
	if (text === lastStatus) return;
	lastStatus = text;

	try {
		ctx.ui.setStatus(STATUS_KEY, text);
	} catch {
		// The context can be torn down between the guard and the call.
	}
}

/** True when the active model runs on OpenRouter, the only balance source. */
function onOpenRouter(ctx: Ctx): boolean {
	return ctx.model?.provider === "openrouter";
}

/** Refresh the OpenRouter account balance without blocking the caller. */
async function refreshBalance(ctx: Ctx): Promise<void> {
	// Balance is OpenRouter-specific: other providers have no equivalent here.
	if (!onOpenRouter(ctx)) {
		balance = undefined;
		return;
	}
	const key = openRouterKey();
	if (!key || fetching) return;
	fetching = true;
	try {
		const response = await fetch(OPENROUTER_CREDITS_URL, { headers: { Authorization: `Bearer ${key}` } });
		if (response.ok) {
			const body = (await response.json()) as { data?: { total_credits?: unknown; total_usage?: unknown } };
			const total = body.data?.total_credits;
			const used = body.data?.total_usage;
			if (active && onOpenRouter(ctx) && typeof total === "number" && typeof used === "number") {
				balance = { remaining: total - used, total };
				render(ctx);
			}
		}
	} catch {
		// Keep the last known balance; a failed refresh is not worth surfacing.
	} finally {
		fetching = false;
	}
}

/** Rebuild session state from the active branch (resume, tree navigation). */
function rebuild(ctx: Ctx): void {
	let sum = 0;
	let last = 0;
	let lastCached = false;
	for (const entry of ctx.sessionManager.getBranch()) {
		if (entry.type !== "custom" || entry.customType !== ENTRY_TYPE) continue;
		const data = entry.data as CostEntry | undefined;
		if (typeof data?.cost === "number") {
			sum += data.cost;
			last = data.cost;
			lastCached = data.cached === true;
		}
	}
	sessionCost = sum;
	lastPromptCost = last;
	lastPromptCached = lastCached;
}

export default function (pi: ExtensionAPI) {
	pi.on("session_start", (_event, ctx) => {
		active = true;
		lastStatus = undefined;
		balance = undefined;
		rebuild(ctx);
		render(ctx);
		void refreshBalance(ctx);
	});

	pi.on("session_shutdown", () => {
		active = false;
		lastStatus = undefined;
	});

	pi.on("session_tree", (_event, ctx) => {
		rebuild(ctx);
		render(ctx);
	});

	// Switching providers changes whether a balance line applies.
	pi.on("model_select", (_event, ctx) => {
		balance = undefined;
		render(ctx);
		void refreshBalance(ctx);
	});

	pi.on("agent_start", () => {
		promptCost = 0;
		promptCalls = 0;
		rawUsage = undefined;
		promptCacheHit = undefined;
	});

	// OpenRouter marks every response with its cache verdict; a HIT means the
	// request was served from cache and billed nothing, so only a prompt whose
	// calls were *all* HITs is genuinely free.
	pi.on("after_provider_response", (event) => {
		const headers = event.headers ?? {};
		const get = (name: string): string | undefined => {
			const key = Object.keys(headers).find((candidate) => candidate.toLowerCase() === name);
			return key ? headers[key] : undefined;
		};

		const cacheStatus = get("x-openrouter-cache-status");
		if (cacheStatus !== undefined) {
			const hit = cacheStatus.toUpperCase() === "HIT";
			promptCacheHit = promptCacheHit === undefined ? hit : promptCacheHit && hit;
		}
	});

	// Some OpenAI-compatible providers (OpenRouter and friends) report the real
	// charge on the final stream chunk, before pi normalizes usage. Read it
	// whenever it is present; everyone else falls back to pi's own cost below.
	pi.on("provider_stream_event", (event) => {
		const usage = (event.data as { usage?: { cost?: unknown; total_tokens?: unknown } } | undefined)?.usage;
		if (!usage || typeof usage.cost !== "number") return;
		rawUsage = {
			totalTokens: typeof usage.total_tokens === "number" ? usage.total_tokens : undefined,
			cost: usage.cost,
		};
	});

	pi.on("message_end", (event) => {
		if (event.message.role !== "assistant") return;
		const usage = (event.message as AssistantMessage).usage;
		promptCalls++;

		// Prefer the provider's real cost when the captured usage is this
		// message's. The token match guards against attributing a nested or
		// compaction call. Otherwise use pi's own pricing.
		const matches = rawUsage && (rawUsage.totalTokens === undefined || rawUsage.totalTokens === usage?.totalTokens);
		promptCost += matches ? rawUsage!.cost : (usage?.cost?.total ?? 0);
		rawUsage = undefined;
	});

	pi.on("agent_settled", (_event, ctx) => {
		// Record the prompt once it made at least one call, even a free one.
		if (promptCalls > 0) {
			lastPromptCost = promptCost;
			lastPromptCached = promptCost === 0 && promptCacheHit === true;
			sessionCost += promptCost;
			// Branch-scoped and invisible to the model; survives resume.
			pi.appendEntry<CostEntry>(ENTRY_TYPE, { cost: promptCost, cached: lastPromptCached });
		}
		render(ctx);
		void refreshBalance(ctx);
	});
}
