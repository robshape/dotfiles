/**
 * Permission Gate Extension
 *
 * Prompts for confirmation before running potentially dangerous bash commands.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	const dangerousPatterns = [
		// Default
		/\brm\s+(-rf?|--recursive)/i,
		/\bsudo\b/i,
		/\b(chmod|chown)\b.*777/i,
		// Running scripts
		/\b(curl|wget)\b.*\|\s*(sudo\s+)?((ba|z)?sh|python3?|perl|ruby|node)\b/i,
		/\b((ba|z)?sh|python3?|perl|ruby|node)\b.*(\$\(|<\(|`)\s*(curl|wget)\b/i,
		// Installing packages
		/\bbrew\s+(install|reinstall|upgrade|tap)\b/i,
		/\b(pnpm|npm)\s+(add|install|i)\b.*\s(-g|--global)\b/i,
		/\b(pip3?|python3?\s+-m\s+pip|pipx|go|gem)\s+install\b/i,
		/\buv\s+tool\s+install\b/i,
		// Publishing packages
		/\b(pnpm|npm)\s+publish\b/i,
		/\b(gem|docker)\s+push\b/i,
	];

	pi.on("tool_call", async (event, ctx) => {
		if (event.toolName !== "bash") return undefined;

		const command = event.input.command as string;
		const isDangerous = dangerousPatterns.some((p) => p.test(command));

		if (isDangerous) {
			if (!ctx.hasUI) {
				// In non-interactive mode, block by default
				return { block: true, reason: "Dangerous command blocked (no UI for confirmation)" };
			}

			const choice = await ctx.ui.select(`⚠️ Dangerous command:\n\n  ${command}\n\nAllow?`, ["Yes", "No"]);

			if (choice !== "Yes") {
				return { block: true, reason: "Blocked by user" };
			}
		}

		return undefined;
	});
}
