# OMO Worktree - Parallel Agent Manager

Run multiple AI agents simultaneously on different branches.

## Quick Start

```
Double-click: Worktree-Menu.bat
```

## Batch Files

| File | What it does |
|------|--------------|
| `Worktree-Menu.bat` | Interactive menu (start here) |
| `Worktree-Create.bat` | Create new worktree with agent |
| `Worktree-List.bat` | Show all worktrees |
| `Worktree-Status.bat` | Status dashboard + conflict check |
| `Worktree-Merge.bat` | Merge worktree back to main |
| `Worktree-Cleanup.bat` | Remove worktrees |

## Workflow

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   CREATE    │ -> │    WORK     │ -> │    MERGE    │ -> │   CLEANUP   │
│ new worktree│    │ agent works │    │ back to main│    │  remove it  │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

## Agents

| Agent | Best For |
|-------|----------|
| `sisyphus` | Main tasks, orchestration |
| `hephaestus` | Deep work, refactoring |
| `oracle` | Debugging, architecture |
| `librarian` | Documentation |
| `explore` | Code exploration |
| `frontend-ui-ux` | UI/UX changes |

## Status Icons

**Worktree:** `[+]` created `[~]` active `[-]` idle `[M]` merged `[x]` cleaned

**Agent:** `[.]` pending `>` running `[ok]` completed `[!]` failed

## Example

```
1. Run Worktree-Create.bat
2. Name: feature-login
3. Agent: 1 (sisyphus)
4. Agent works on login feature...

5. Run Worktree-Status.bat
6. Check conflicts: y

7. Run Worktree-Merge.bat
8. Name: feature-login
9. Squash: y

10. Run Worktree-Cleanup.bat
11. Remove merged worktrees
```

## Data Location

```
F:\OpenOhMyCodePortable\.omo\worktrees.json
```

---

## Playwright (Browser Automation)

Install Chromium for browser automation tasks:

| File | What it does |
|------|--------------|
| `Install-Playwright.bat` | Download Chromium (~135MB) |
| `Check-Playwright.bat` | Check installation status |

**Usage:**
1. Run `Install-Playwright.bat` once to download Chromium
2. Playwright is auto-configured to use the bundled browser
3. Browser stored in: `F:\OpenOhMyCodePortable\browsers\`

```
F:\OpenOhMyCodePortable\.omo\worktrees.json
```
