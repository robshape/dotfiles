/**
 * Confine-to-CWD Extension
 *
 * Blocks filesystem access outside the directory pi was started in (plus RW_DIRS / RO_DIRS).
 * `~`/`$HOME` are expanded and symlinks followed.
 *
 * Path tools are checked exactly. Shell commands are best-effort: `cd`/`pushd`/`popd` are
 * followed within a command, and path-like tokens are resolved against the tracked directory.
 * Variables, `eval`, etc. can still slip through.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { existsSync, realpathSync } from "node:fs";
import { homedir } from "node:os";
import { basename, dirname, resolve, sep } from "node:path";

const HOME = homedir();
const TOOLS: Record<string, "read" | "write" | "shell"> = {
	read: "read",
	ls: "read",
	grep: "read",
	find: "read",
	write: "write",
	edit: "write",
	bash: "shell",
	powershell: "shell",
};

/** Resolve symlinks; for missing paths, resolve the nearest existing parent. */
function real(p: string): string {
	try {
		return realpathSync(p);
	} catch {
		const parent = dirname(p);
		return parent === p ? p : resolve(real(parent), basename(p));
	}
}

const RW_DIRS = [resolve(HOME, ".pi"), "/tmp", resolve(HOME, "Developer/shapeless-gh/dotfiles")].map(real);
const PI_PKG = process.argv[1] && real(process.argv[1]).match(/^.*\/node_modules\/@earendil-works\/pi-coding-agent/)?.[0];
const RO_DIRS = PI_PKG ? [PI_PKG] : [];

const HOME_RE = /^(~|\$HOME|\$\{HOME\})(?=\/|$)/;
/** Path-like shell tokens: absolute, `~`/`$HOME`-prefixed, or containing `..`. */
const PATH_RE = /(?<![\w.$:/-])(?:~|\$HOME|\$\{HOME\}|\/|[\w.-]*\.\.(?=\/|$|[\s'"`;|&)]))[^\s'"`;|&()<>]*/g;
/** Command separators. Parens mark subshells; `&` skips redirections like `2>&1`. */
const SEP_RE = /(\|\||&&|;|\n|\(|\)|\||(?<![<>&])&(?!>))/;
/** `cd`/`pushd`/`popd` at segment start, optionally after shell keywords. */
const CD_RE = /^\s*(?:(?:if|then|else|elif|do|while|until|!|\{)\s+)*(cd|pushd|popd)(?:\s+(.*))?$/s;

/** Resolve `raw` against `base`, mirroring pi's path-utils (strip leading `@`, expand `~`). */
const toAbs = (base: string, raw: string) => real(resolve(base, raw.replace(/^@/, "").replace(HOME_RE, HOME)));
const within = (p: string, dir: string) => p === dir || p.startsWith(dir.endsWith(sep) ? dir : dir + sep);

export function isAllowed(root: string, raw: string, write: boolean, base = root): boolean {
	const p = toAbs(base, raw);
	return p === "/dev/null" || [real(root), ...RW_DIRS, ...(write ? [] : RO_DIRS)].some((d) => within(p, d));
}

/** Returns the first offending path/segment in a shell command, if any. */
export function checkShell(root: string, command: string): string | undefined {
	const parts = command.split(SEP_RE); // [segment, separator, segment, ...]
	const subshells: string[] = [];
	const pushed: string[] = [];
	let dir = real(root);
	let prev = dir;

	for (let i = 0; i < parts.length; i += 2) {
		const [before, seg, after] = [parts[i - 1], parts[i], parts[i + 1]];

		for (const p of seg.match(PATH_RE) ?? []) {
			// Skip `/foo` tokens whose top-level dir doesn't exist (regexes, URLs paths, etc.).
			if (p.startsWith("/") && !existsSync("/" + p.split("/")[1])) continue;
			if (!isAllowed(root, p, true, dir)) return p;
		}

		const cd = seg.match(CD_RE);
		if (cd) {
			const arg = cd[2]
				?.split(/\s+/)
				.find((a) => a && !/^-[LPe@]+$/.test(a))
				?.replace(/['"]/g, "");
			const target =
				cd[1] === "popd" ? pushed.at(-1)
				: arg === undefined ? HOME
				: arg === "-" ? prev
				: /[$`]/.test(arg.replace(HOME_RE, "")) ? undefined
				: arg;
			if (target === undefined) return seg.trim();
			if (!isAllowed(root, target, true, dir)) return target;
			// Pipelines and background jobs run in subshells, so their `cd` doesn't stick.
			if (![before, after].some((s) => s === "|" || s === "&")) {
				if (cd[1] === "pushd") pushed.push(dir);
				if (cd[1] === "popd") pushed.pop();
				[prev, dir] = [dir, toAbs(dir, target)];
			}
		}

		if (after === "(") subshells.push(dir);
		if (after === ")") dir = subshells.pop() ?? dir;
	}
}

export default function (pi: ExtensionAPI) {
	pi.on("tool_call", (event, ctx) => {
		const { command = "", path = "" } = event.input as { command?: string; path?: string };
		const kind = TOOLS[event.toolName];
		const bad =
			kind === "shell" ? checkShell(ctx.cwd, command)
			: kind && path && !isAllowed(ctx.cwd, path, kind === "write") ? path
			: undefined;
		if (bad === undefined) return undefined;
		return {
			block: true,
			reason: `"${bad}" is outside the allowed area. This access is not permitted. Do not retry it or try alternatives (shell tricks, symlinks, env vars, encoding) to bypass the restriction. Continue using only the working directory and: ${RW_DIRS.join(", ")}.`,
		};
	});
}
