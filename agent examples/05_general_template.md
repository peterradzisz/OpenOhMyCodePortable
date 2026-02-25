# AGENTS.md – General Template (by betatim)

Source: [gist.github.com/betatim](https://gist.github.com/betatim/4b205de0b762f8c7865ea2e0ea5c65b4)

## Core Principles

These principles reduce common LLM coding mistakes. Apply them to every task.

### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

- State assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them — don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

**The test:** Would a senior engineer say this is overcomplicated? If yes, simplify.

### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it — don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

**The test:** Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution (TDD)

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

| Instead of... | Transform to... |
|---------------|-----------------|
| "Add validation" | "Write tests for invalid inputs, then make them pass" |
| "Fix the bug" | "Write a test that reproduces it, then make it pass" |
| "Refactor X" | "Ensure tests pass before and after" |

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

---

## Running Commands

Run all commands in the `foobar` conda environment. Really all commands, not just those related to Python.

---

## Code style

- Do not use type annotations
- Import statements at the top of the file, very rarely is there a need for inline imports
- Comments explain why, not what the code does
  - Do not add single line comments that state what the next line of code does

### Formatting and linting

This project uses `ruff` for formatting and linting.

- Format: `ruff format .`
- Lint: `ruff check .`
- Lint and auto-fix: `ruff check --fix .`

Run these from the project root before committing.

---

## Before Starting Work

1. Read `agents/plans/current.md` for current status
2. Read relevant `agents/designs/*.md` for architecture context

---

## Plans

When asked to make a plan or perform research always store the resulting plan and design documents as a markdown file in `agents/plans/`.

Include the date the plan was first created as well as the last time it was edited at the top of the file.

---

## Designs

Design and architecture decisions are in `agents/designs/`. Use it to record learnings and why decisions were made.
