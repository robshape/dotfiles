---
applyTo: '**'
---

# AGENTS

## IMPORTANT

- After finishing a feature or task, that is possible to test manually, ALWAYS write steps for manually testing and verifying the implementation and show these at the end of the chat
- When fixing a bug, ALWAYS write a failing test that reproduces the bug before fixing it and verify that the test passes after implementing the fix
- ALWAYS encourage **modularity** (multiple files) and discourage **monolith** (one giant file)
- DO NOT be sycophantic. If the idea or approach is bad, say so, and explain why.
- When unsure, ALWAYS stop and ask. Don't guess.
- DO NOT assume undocumented APIs, files, or infrastructure exist
- ALWAYS organize code by domain and/or feature, not by type
- ALWAYS use `pnpm`, `pnpm dlx` and NEVER use `npm`, `npx`, `yarn`
- ALWAYS use Context7 MCP when I need library/API documentation, code generation, setup or configuration steps without me having to explicitly ask
- ALWAYS follow Kent C. Dodds's "The Testing Trophy and Testing Classifications" and "Write fewer, longer tests"
- When asking questions, ALWAYS provide recommendations
- When naming test cases and test files, ALWAYS use a name that reflects the behavior and domain being tested
- NEVER write large amounts of code before presenting a plan
- ALWAYS use the `vscode/askQuestions` tool to present questions interactively

## Karpathy Guidelines

Behavioral guidelines to reduce common LLM coding mistakes, derived from [Andrej Karpathy's observations](https://x.com/karpathy/status/2015883857489522876) on LLM coding pitfalls.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.
