/**
 * Confine-to-CWD Extension
 *
 * Blocks filesystem access outside the current working directory.
 * Paths are resolved with `~`/`$HOME` expanded and symlinks followed.
 *
 * Allowed outside cwd:
 *   - ~/.pi/ and /tmp/ (read + write)
 *   - pi's own install directory (read-only, for docs/examples)
 *   - /dev/null
 *
 * Path tools (read, ls, grep, find, write, edit) are checked exactly.
 * Shell tools (bash, powershell) are best-effort: path-like tokens are
 * extracted with a regex, so variables, `cd /` tricks etc. can slip through.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { realpathSync } from "node:fs";
import { homedir } from "node:os";
import { dirname, resolve, sep } from "node:path";

const STOP_HINT =
	"This access is not permitted. Do not attempt to read this path again, " +
	"and do not try alternative methods (shell commands, symlinks, env vars, " +
	"encoding tricks) to bypass the restriction. Continue with the task using " +
	"only files inside the working directory (and ~/.pi for configuration).";

const READ_TOOLS = new Set(["read", "ls", "grep", "find"]);
const WRITE_TOOLS = new Set(["write", "edit"]);
const SHELL_TOOLS = new Set(["bash", "powershell"]);

/** Path-like shell tokens: absolute, `~`/`$HOME`-prefixed, or containing `..`. */
const SHELL_PATH_RE = /(?<![\w.$:/-])(?:~|\$HOME|\$\{HOME\}|\/|[\w.-]*\.\.(?=\/|$|[\s'"`;|&)]))[^\s'"`;|&()<>]*/g;

/** Resolve symlinks; for paths that don't exist yet, resolve the nearest existing parent. */
function real(abs: string): string {
	try {
		return realpathSync(abs);
	} catch {
		const parent = dirname(abs);
		return parent === abs ? abs : resolve(real(parent), abs.slice(parent.length + 1));
	}
}

const within = (abs: string, dir: string) => abs === dir || abs.startsWith(dir.endsWith(sep) ? dir : dir + sep);

const RW_DIRS = [resolve(homedir(), ".pi"), "/tmp"].map(real);
const PI_PKG = real(process.argv[1] ?? "").match(/^.*\/node_modules\/@earendil-works\/pi-coding-agent/)?.[0];
const RO_DIRS = PI_PKG ? [PI_PKG] : [];

export function isAllowed(cwd: string, raw: string, write: boolean): boolean {
	// Mirror pi's path-utils: strip a leading `@` (file mentions), then expand `~`.
	const expanded = raw.replace(/^@/, "").replace(/^(~|\$HOME|\$\{HOME\})(?=\/|$)/, homedir());
	const abs = real(resolve(cwd, expanded));
	const dirs = [real(cwd), ...RW_DIRS, ...(write ? [] : RO_DIRS)];
	return abs === "/dev/null" || dirs.some((dir) => within(abs, dir));
}

export default function (pi: ExtensionAPI) {
	pi.on("tool_call", (event, ctx) => {
		const input = event.input as { command?: string; path?: string };
		const name = event.toolName;

		// Shell commands may write anywhere they mention, so check as writes.
		const paths = SHELL_TOOLS.has(name)
			? (input.command?.match(SHELL_PATH_RE) ?? [])
			: READ_TOOLS.has(name) || WRITE_TOOLS.has(name)
				? [input.path ?? ""].filter(Boolean)
				: [];
		const write = !READ_TOOLS.has(name);

		const bad = paths.find((p) => !isAllowed(ctx.cwd, p, write));
		if (bad === undefined) return undefined;
		return { block: true, reason: `Path "${bad}" is outside the allowed area. ${STOP_HINT}` };
	});
}
