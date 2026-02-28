---
name: surgical-edit-discipline
description: Enforces minimal, targeted edits - prevents full file rewrites
---

# Surgical Edit Discipline

## CRITICAL: You are a SURGEON, not a rewriter.

### Absolute Rules

1. **NEVER rewrite an entire file** unless explicitly asked
2. **ONLY modify the specific lines that need changing**
3. **PRESERVE all surrounding code exactly** - whitespace, formatting, comments
4. **NEVER "improve" or reformat adjacent code** - that's scope creep

### Edit Tool Usage

**PREFER the Write tool for file modifications:**

```
✅ CORRECT: Read full file, modify content, write complete file
✅ CORRECT: Preserves indentation, avoids Edit tool bugs
❌ WRONG: Edit with pos/end (can cause indentation/duplication bugs)
❌ WRONG: "Clean up" formatting while making your edit
❌ WRONG: Add "helpful" changes beyond what was requested
```

### Write Workflow (Preferred)

1. **READ** the file first - understand current state
2. **MODIFY** the content in memory
3. **WRITE** the complete modified file
4. **VERIFY** by reading the changed section

### When to Use Each Tool

| Tool | When to Use |
|------|-------------|
| `write` | **DEFAULT** - Read full file, write modified content (avoids Edit tool bugs) |
| `edit` | ONLY for single-line changes where precision is critical |

### WORKAROUND: MiniMax/GLM Models (KNOWN BUG - Issue #10656)

**Due to a known bug in OpenCode, MiniMax-M2.x and GLM models may produce incorrect indentation or duplicate code when using the Edit tool.**

**When using these models (`minimax/*`, `z-ai/*`, `kimi/*`):**
- **PREFER `write`** over `edit` for file modifications
- Read the full file, then write the complete modified content
- This is a temporary workaround until the bug is fixed

**When using other models (claude, gpt, copilot, etc.):**
- Continue using `edit` as the default (see table above)

<!--
REMOVE THIS SECTION when OpenCode fixes Issue #10656
Bug: Edit tool causes indentation errors with Chinese models
Tracking: https://github.com/anomalyco/opencode/issues/10656
-->

### Examples

**User asks: "Change the button color to blue"**

```
❌ OLD WAY: Edit only the color property line
✅ NEW WAY: 
   1. Read entire CSS file
   2. Modify the button color property
   3. Write complete file back
```

**User asks: "Fix the typo in line 45"**

```
❌ OLD WAY: Edit line 45 only with pos parameter
✅ NEW WAY:
   1. Read the file
   2. Fix the typo in memory
   3. Write complete file back
```

### Anti-Patterns to Avoid

- "While I'm here, let me also..."
- "I noticed this could be improved..."
- "Let me clean up the formatting..."
- Rewriting a function to change one line
- Deleting and recreating instead of editing

### Scope Control

**Your edit scope = exactly what was requested, nothing more.**

If you see related issues:
1. Complete the requested edit first
2. THEN mention the other issues separately
3. Let the user decide if they want those changes

### Verification

After each edit:
1. Confirm only targeted lines changed
2. No unintended modifications
3. File structure preserved
4. No duplicate lines introduced
