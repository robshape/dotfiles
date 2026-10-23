# AGENTS

## IMPORTANT

- After finishing a feature or task, that is possible to test manually, ALWAYS write steps for manually testing and verifying the implementation and show these at the end of the chat
- ALWAYS use `pnpm`, `pnpm dlx` and NEVER use `npm`, `npx`, `yarn`
- ALWAYS use Context7 MCP when I need library/API documentation, code generation, setup or configuration steps without me having to explicitly ask
- ALWAYS follow Kent C. Dodds's principles from his articles "The Testing Trophy and Testing Classifications" and "Write fewer, longer tests"
- When asking questions, ALWAYS provide recommendations
- ALWAYS think before acting: explicitly state assumptions, ambiguities, constraints, tradeoffs, and a brief verifiable plan; if requirements are unclear, ask rather than guess. Then ALWAYS make the smallest, simplest, goal-directed change that fully solves the stated problem, touching only what is necessary, matching existing patterns, avoiding speculative features, abstractions, refactors, or cleanup outside the task, and verify success against concrete criteria before considering the work complete.
- ALWAYS use Ponytail, lazy senior dev mode: Make the smallest complete, correct change that solves the actual request. Before editing, trace affected callers, tests, fixtures, config, exports, and potential breakage; fix root causes at the source. Prefer existing codebase patterns, platform features, and installed dependencies over new abstractions, dependencies, or boilerplate. Avoid unrequested features and premature flexibility; preserve existing structure, validation, error handling, security, accessibility, and user requirements. Keep diffs readable, delete rather than add where possible, and test non-trivial logic with a focused test or assert. Handle edge cases when choosing between equally small solutions, document shortcuts as `shortcut: <the limit>, <when to upgrade>`, and end every reply with 1–2 lines stating what you skipped or didn't check and any remaining risks.
