# Git Worktrees + Parallel Agent Orchestration

## TL;DR

> **Quick Summary**: Implement git worktrees-based parallel agent execution for Oh My OpenCode, enabling multiple AI agents to work simultaneously on different branches without conflicts.
>
> **Deliverables**:
> - `omo worktree` CLI commands (create, list, status, merge, cleanup)
> - Agent-to-worktree assignment system
> - Status dashboard for tracking all parallel agents
> - Conflict detection and prevention
> - Windows-compatible unified view (tmux alternative)
>
> **Estimated Effort**: Large
> **Parallel Execution**: YES - 5 waves
> **Critical Path**: Core Worktree Manager → Agent Orchestrator → Status Dashboard → Integration Tests

---

## Context

### Original Request
User wants to improve OpenCode/Oh My OpenCode by implementing parallel agent execution using git worktrees, inspired by trending tools like workmux, agent-worktree, and emdash.

### User's Current Pain Points
1. **Branch/file conflicts** when running multiple agents
2. **No coordination** between agents
3. **Context switching** between multiple OpenCode windows

### User's Use Cases
- Code + Review + Docs running in parallel
- Different features on same repository
- Testing/experimenting alongside main work

### Research Findings

**workmux** (818 stars, Rust):
- git worktrees + tmux for zero-friction parallel dev
- Opinionated but composable architecture
- Key insight: Terminal handles windowing, git handles branches

**agent-worktree** (113 stars, Rust):
- "Snap mode" - create worktree, run agent, merge, cleanup
- Temporary worktrees for agent tasks
- npm distribution for easy install

**emdash** (YC W26, 1,536 stars):
- Full parallel agent orchestration
- Docker containerization
- Git worktrees + Jira/Linear integration

### Technical Constraints
- **Platform**: Windows (tmux not native)
- **Stack**: TypeScript + Bun runtime
- **Integration**: Must work with existing OMO agent system (Sisyphus, Oracle, Librarian, etc.)
- **No Docker required**: Lightweight solution without containerization overhead

### Portable Bundle Scope (CRITICAL)
- **Target**: `F:\OpenOhMyCodePortable` portable bundle ONLY
- **Do NOT affect**: Global OMO installation at `~/.config/opencode/` or `npm install -g oh-my-opencode`
- **All changes**: Local to portable bundle directory
- **Config location**: `F:\OpenOhMyCodePortable\config\` (already exists)
- **Worktree metadata**: `F:\OpenOhMyCodePortable\.omo\worktrees.json`
- **Commands**: `omo` CLI within portable bundle (not global `oh-my-opencode`)

### Guardrails for Portable Scope
- ❌ No modifications to global npm packages
- ❌ No changes to `~/.config/opencode/`
- ❌ No system-wide installations
- ✅ All code in `F:\OpenOhMyCodePortable\app\node_modules\oh-my-opencode\`
- ✅ Config in `F:\OpenOhMyCodePortable\config\`
- ✅ Metadata in `F:\OpenOhMyCodePortable\.omo\`
---

## Work Objectives

### Core Objective
Enable multiple Oh My OpenCode agents to work simultaneously on the same repository without file conflicts, with centralized coordination and status tracking.

### Concrete Deliverables
1. **CLI Commands**: `omo worktree create|list|status|merge|cleanup`
2. **Agent Orchestrator**: Assigns agents to worktrees, tracks progress
3. **Status Dashboard**: Real-time view of all running agents
4. **Conflict Prevention**: File locking, branch awareness
5. **Documentation**: User guide and architecture docs

### Definition of Done
- [ ] Can create worktree and assign agent in single command
- [ ] Can list all running worktrees with status
- [ ] Can merge worktree changes back to main branch
- [ ] Can cleanup worktrees after merge
- [ ] Status dashboard shows all agent activity
- [ ] No file conflicts when multiple agents run

### Must Have
- Git worktree creation/deletion
- Agent-to-worktree binding
- Status tracking
- Merge workflow
- Windows compatibility

### Must NOT Have (Guardrails)
- Docker/containerization (too heavyweight)
- Linux-only features (tmux, signals)
- Changes to core OpenCode (OMO plugin only)
- Breaking existing OMO workflows
- Auto-merge without user confirmation
- **Modifications to global OMO installation** (portable bundle only)
- **Changes to `~/.config/opencode/`** (use portable config)
- **System-wide npm package changes** (local only)

---

## Verification Strategy

### Test Decision
- **Infrastructure exists**: YES (bun test in OMO)
- **Automated tests**: TDD - each feature has tests first
- **Framework**: bun test

### QA Policy
Every task includes agent-executed QA scenarios using:
- **CLI**: Bash commands to test worktree operations
- **Git**: Verify branch state, worktree status
- **File System**: Check worktree directories exist/clean

---

## Execution Strategy

### Parallel Execution Waves

```
Wave 1 (Foundation - 5 tasks parallel):
├── Task 1: Worktree Manager Core [deep]
├── Task 2: Git Operations Layer [quick]
├── Task 3: Type Definitions [quick]
├── Task 4: Configuration Schema [quick]
└── Task 5: Error Handling Framework [quick]

Wave 2 (Core Features - 5 tasks parallel):
├── Task 6: Worktree Create Command [deep]
├── Task 7: Worktree List Command [quick]
├── Task 8: Worktree Status Command [quick]
├── Task 9: Agent Assignment System [deep]
└── Task 10: Worktree Metadata Store [unspecified-high]

Wave 3 (Orchestration - 4 tasks parallel):
├── Task 11: Agent Orchestrator [deep]
├── Task 12: Status Dashboard [visual-engineering]
├── Task 13: Conflict Detection [unspecified-high]
└── Task 14: Worktree Merge Command [deep]

Wave 4 (Integration - 4 tasks parallel):
├── Task 15: CLI Integration [quick]
├── Task 16: Hook Integration [unspecified-high]
├── Task 17: Cleanup Command [quick]
└── Task 18: Documentation [writing]

Wave FINAL (Verification - 4 tasks parallel):
├── Task F1: Plan Compliance Audit [oracle]
├── Task F2: Code Quality Review [unspecified-high]
├── Task F3: Integration QA [deep]
└── Task F4: Scope Fidelity Check [deep]

Critical Path: T1 → T6 → T9 → T11 → T14 → F1-F4
Parallel Speedup: ~60% faster than sequential
Max Concurrent: 5 (Waves 1 & 2)
```

### Dependency Matrix

| Task | Depends On | Blocks |
|------|------------|--------|
| 1-5 | — | 6-10 |
| 6 | 1, 2 | 11, 14 |
| 7-8 | 1, 2 | 12 |
| 9 | 1, 3 | 11 |
| 10 | 3, 4 | 11, 13 |
| 11 | 6, 9, 10 | 15, 16 |
| 12 | 7, 8, 10 | F3 |
| 13 | 10 | 14 |
| 14 | 6, 13 | 17 |
| 15 | 11 | F3 |
| 16 | 11 | F3 |
| 17 | 14 | F3 |
| 18 | 15 | — |
| F1-F4 | ALL | — |

### Agent Dispatch Summary

- **Wave 1**: 5 tasks → T1 `deep`, T2-T5 `quick`
- **Wave 2**: 5 tasks → T6,T9 `deep`, T7-T8 `quick`, T10 `unspecified-high`
- **Wave 3**: 4 tasks → T11,T14 `deep`, T12 `visual-engineering`, T13 `unspecified-high`
- **Wave 4**: 4 tasks → T15,T17 `quick`, T16 `unspecified-high`, T18 `writing`
- **Wave FINAL**: 4 tasks → F1 `oracle`, F2 `unspecified-high`, F3,F4 `deep`

---

## TODOs

### Wave 1: Foundation

- [ ] 1. **Worktree Manager Core**

  **What to do**:
  - Create `src/worktree/manager.ts` with core worktree management logic
  - Implement `WorktreeManager` class with methods: `create()`, `delete()`, `list()`, `get()`
  - Add worktree state tracking (created, active, merged, cleaned)
  - Write unit tests for each method

  **Must NOT do**:
  - Don't implement git operations (Task 2 handles that)
  - Don't add CLI commands (Task 6+ handles that)

  **Recommended Agent Profile**:
  - **Category**: `deep`
    - Reason: Core infrastructure requiring careful design
  - **Skills**: [`git-master`]
    - `git-master`: Understanding git worktree concepts

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1 (with Tasks 2, 3, 4, 5)
  - **Blocks**: Tasks 6, 9
  - **Blocked By**: None

  **References**:
  - `src/cli/cli-program.ts` - Existing CLI structure pattern
  - Git worktree docs: https://git-scm.com/docs/git-worktree

  **Acceptance Criteria**:
  - [ ] `WorktreeManager` class exists with all methods
  - [ ] Unit tests pass: `bun test src/worktree/manager.test.ts`
  - [ ] Type definitions for worktree state

  **QA Scenarios**:
  ```
  Scenario: Create worktree manager instance
    Tool: Bash
    Steps:
      1. cd /path/to/omo && bun test src/worktree/manager.test.ts
    Expected Result: All tests pass
    Evidence: .sisyphus/evidence/task-1-manager-tests.txt
  ```

  **Commit**: YES
  - Message: `feat(worktree): add WorktreeManager core`
  - Files: `src/worktree/manager.ts, src/worktree/manager.test.ts`
  - Pre-commit: `bun test src/worktree/manager.test.ts`

- [ ] 2. **Git Operations Layer**

  **What to do**:
  - Create `src/worktree/git-operations.ts`
  - Implement git command wrappers: `git worktree add`, `git worktree list`, `git worktree remove`
  - Add branch operations: `createBranch()`, `checkoutBranch()`
  - Handle git errors gracefully
  - Write unit tests with mocked git commands

  **Must NOT do**:
  - Don't call git commands directly - use child_process with proper error handling
  - Don't modify working directory state in tests

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: Well-defined scope, clear API
  - **Skills**: [`git-master`]
    - `git-master`: Git command expertise required

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: Tasks 6, 7, 8
  - **Blocked By**: None

  **References**:
  - `src/hooks/auto-slash-command/executor.ts` - Child process patterns
  - Git documentation for worktree commands

  **Acceptance Criteria**:
  - [ ] All git worktree commands wrapped
  - [ ] Error handling for common git failures
  - [ ] Tests pass with mocked git

  **QA Scenarios**:
  ```
  Scenario: Git operations return correct output
    Tool: Bash
    Steps:
      1. bun test src/worktree/git-operations.test.ts
    Expected Result: All tests pass, git commands mocked correctly
    Evidence: .sisyphus/evidence/task-2-git-tests.txt
  ```

  **Commit**: YES (groups with Task 1)

- [ ] 3. **Type Definitions**

  **What to do**:
  - Create `src/worktree/types.ts`
  - Define interfaces: `Worktree`, `WorktreeStatus`, `AgentAssignment`, `WorktreeConfig`
  - Export types for use across the module
  - Add JSDoc documentation

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: Pure type definitions, no logic
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: Tasks 9, 10
  - **Blocked By**: None

  **Acceptance Criteria**:
  - [ ] All types defined with JSDoc
  - [ ] Types compile without errors

  **Commit**: YES (groups with Task 1)

- [ ] 4. **Configuration Schema**

  **What to do**:
  - Add worktree config to `oh-my-opencode.json` schema
  - Define default settings: max worktrees, naming convention, cleanup policy
  - Create config validation with Zod or similar
  - Add to JSON schema for IDE autocomplete

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: Task 10
  - **Blocked By**: None

  **Acceptance Criteria**:
  - [ ] Schema updated with worktree config
  - [ ] Validation works
  - [ ] IDE autocomplete shows new options

  **Commit**: YES (groups with Task 1)

- [ ] 5. **Error Handling Framework**

  **What to do**:
  - Create `src/worktree/errors.ts`
  - Define custom error classes: `WorktreeError`, `ConflictError`, `MergeError`
  - Add error recovery suggestions
  - Write tests for error scenarios

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: None directly
  - **Blocked By**: None

  **Commit**: YES (groups with Task 1)

---

### Wave 2: Core CLI Commands

- [ ] 6. **Worktree Create Command**

  **What to do**:
  - Add `omo worktree create <name>` command to CLI
  - Options: `--agent`, `--branch`, `--from`
  - Integrate with WorktreeManager and GitOperations
  - Create worktree directory and initialize agent
  - Write integration tests

  **Must NOT do**:
  - Don't auto-start agent (just prepare the environment)
  - Don't modify main branch

  **Recommended Agent Profile**:
  - **Category**: `deep`
    - Reason: Complex integration with multiple systems
  - **Skills**: [`git-master`]

  **Parallelization**:
  - **Can Run In Parallel**: YES (after Wave 1)
  - **Parallel Group**: Wave 2
  - **Blocks**: Tasks 11, 14
  - **Blocked By**: Tasks 1, 2

  **QA Scenarios**:
  ```
  Scenario: Create worktree with agent assignment
    Tool: Bash
    Steps:
      1. omo worktree create test-feature --agent sisyphus
      2. git worktree list | grep test-feature
    Expected Result: Worktree created, listed in git worktree list
    Evidence: .sisyphus/evidence/task-6-create.txt

  Scenario: Create fails on duplicate name
    Tool: Bash
    Steps:
      1. omo worktree create test-feature --agent sisyphus
      2. omo worktree create test-feature --agent oracle
    Expected Result: Second command fails with "already exists" error
    Evidence: .sisyphus/evidence/task-6-create-error.txt
  ```

  **Commit**: YES
  - Message: `feat(worktree): add create command`

- [ ] 7. **Worktree List Command**

  **What to do**:
  - Add `omo worktree list` command
  - Display table: name, branch, agent, status, path
  - Support JSON output with `--json` flag
  - Filter options: `--status`, `--agent`

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2
  - **Blocks**: Task 12
  - **Blocked By**: Tasks 1, 2

  **QA Scenarios**:
  ```
  Scenario: List shows all worktrees
    Tool: Bash
    Steps:
      1. omo worktree create feature-a --agent sisyphus
      2. omo worktree create feature-b --agent oracle
      3. omo worktree list
    Expected Result: Table shows both worktrees with correct info
    Evidence: .sisyphus/evidence/task-7-list.txt
  ```

  **Commit**: YES (groups with Task 6)

- [ ] 8. **Worktree Status Command**

  **What to do**:
  - Add `omo worktree status <name>` command
  - Show: agent progress, files modified, merge readiness, conflicts
  - Support watch mode with `--watch` flag

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2
  - **Blocks**: Task 12
  - **Blocked By**: Tasks 1, 2

  **Commit**: YES (groups with Task 6)

- [ ] 9. **Agent Assignment System**

  **What to do**:
  - Create `src/worktree/agent-assignment.ts`
  - Implement `assignAgent(worktree, agentName)` function
  - Store assignment in metadata (Task 10)
  - Validate agent exists and is available
  - Track agent lifecycle in worktree

  **Recommended Agent Profile**:
  - **Category**: `deep`
    - Reason: Complex state management
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2
  - **Blocks**: Task 11
  - **Blocked By**: Tasks 1, 3

  **Commit**: YES (groups with Task 6)

- [ ] 10. **Worktree Metadata Store**

  **What to do**:
  - Create `src/worktree/metadata-store.ts`
  - Store: worktree info, agent assignment, status, timestamps
  - Use JSON file in `F:\\OpenOhMyCodePortable\.omo\worktrees.json` (portable bundle location)
  - Implement CRUD operations
  - Add atomic write for crash safety

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
    - Reason: Requires careful design for reliability
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2
  - **Blocks**: Tasks 11, 13
  - **Blocked By**: Tasks 3, 4

  **Commit**: YES (groups with Task 6)

---

### Wave 3: Orchestration

- [ ] 11. **Agent Orchestrator**

  **What to do**:
  - Create `src/worktree/orchestrator.ts`
  - Implement `Orchestrator` class to manage all parallel agents
  - Methods: `startAgent()`, `stopAgent()`, `getAgentStatus()`, `waitForCompletion()`
  - Coordinate between multiple worktrees
  - Emit events for status dashboard

  **Recommended Agent Profile**:
  - **Category**: `deep`
    - Reason: Core orchestration logic
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES (after Wave 2)
  - **Parallel Group**: Wave 3
  - **Blocks**: Tasks 15, 16
  - **Blocked By**: Tasks 6, 9, 10

  **QA Scenarios**:
  ```
  Scenario: Start multiple agents in parallel
    Tool: Bash
    Steps:
      1. omo worktree create feat-a --agent sisyphus
      2. omo worktree create feat-b --agent oracle
      3. omo worktree start feat-a & omo worktree start feat-b &
      4. sleep 5 && omo worktree list
    Expected Result: Both agents running, status shows active
    Evidence: .sisyphus/evidence/task-11-parallel.txt
  ```

  **Commit**: YES
  - Message: `feat(worktree): add agent orchestrator`

- [ ] 12. **Status Dashboard**

  **What to do**:
  - Create `src/worktree/dashboard.ts`
  - Implement terminal dashboard showing all worktrees
  - Use terminal UI library (ink or blessed for Windows compatibility)
  - Show: worktree name, agent, progress bar, files changed
  - Add refresh with `r` key, quit with `q`

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
    - Reason: TUI/UX design required
  - **Skills**: [`frontend-ui-ux`]
    - `frontend-ui-ux`: Terminal UI design

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 3
  - **Blocks**: Task F3
  - **Blocked By**: Tasks 7, 8, 10

  **QA Scenarios**:
  ```
  Scenario: Dashboard displays correctly
    Tool: interactive_bash (tmux)
    Steps:
      1. Create 2 worktrees with agents
      2. Run omo worktree dashboard
      3. Verify both worktrees visible
      4. Press 'q' to quit
    Expected Result: Dashboard shows all worktrees, keyboard works
    Evidence: .sisyphus/evidence/task-12-dashboard.png
  ```

  **Commit**: YES (groups with Task 11)

- [ ] 13. **Conflict Detection**

  **What to do**:
  - Create `src/worktree/conflict-detector.ts`
  - Detect file conflicts between worktrees
  - Check for: same file modified in multiple worktrees
  - Warn before merge if conflicts detected
  - Suggest resolution strategies

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: [`git-master`]

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 3
  - **Blocks**: Task 14
  - **Blocked By**: Task 10

  **QA Scenarios**:
  ```
  Scenario: Detect conflict before merge
    Tool: Bash
    Steps:
      1. Create worktree-a, modify src/file.ts
      2. Create worktree-b, modify same src/file.ts
      3. omo worktree merge worktree-a
      4. omo worktree status worktree-b
    Expected Result: worktree-b shows conflict warning
    Evidence: .sisyphus/evidence/task-13-conflict.txt
  ```

  **Commit**: YES (groups with Task 11)

- [ ] 14. **Worktree Merge Command**

  **What to do**:
  - Add `omo worktree merge <name>` command
  - Options: `--no-cleanup` to keep worktree after merge
  - Check for conflicts before merge
  - Prompt for confirmation
  - Merge to main branch
  - Optionally cleanup worktree

  **Recommended Agent Profile**:
  - **Category**: `deep`
    - Reason: Critical git operations
  - **Skills**: [`git-master`]

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 3
  - **Blocks**: Task 17
  - **Blocked By**: Tasks 6, 13

  **QA Scenarios**:
  ```
  Scenario: Merge worktree successfully
    Tool: Bash
    Steps:
      1. omo worktree create feature --agent sisyphus
      2. # Make changes in worktree
      3. omo worktree merge feature --yes
      4. git log --oneline -1
    Expected Result: Changes merged, commit visible
    Evidence: .sisyphus/evidence/task-14-merge.txt
  ```

  **Commit**: YES (groups with Task 11)

---

### Wave 4: Integration & Docs

- [ ] 15. **CLI Integration**

  **What to do**:
  - Integrate all worktree commands into main CLI
  - Add `omo worktree` as subcommand group
  - Update help text and examples
  - Add shell completion support

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 4
  - **Blocks**: Task F3
  - **Blocked By**: Task 11

  **Commit**: YES
  - Message: `feat(worktree): integrate CLI commands`

- [ ] 16. **Hook Integration**

  **What to do**:
  - Create hooks for worktree events
  - `worktree.created`, `worktree.merged`, `worktree.cleaned`
  - Allow custom hooks per worktree
  - Integrate with existing OMO hook system

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 4
  - **Blocks**: Task F3
  - **Blocked By**: Task 11

  **Commit**: YES (groups with Task 15)

- [ ] 17. **Cleanup Command**

  **What to do**:
  - Add `omo worktree cleanup <name>` command
  - Remove worktree directory
  - Delete branch if requested
  - Update metadata store
  - Add `omo worktree cleanup --all` for batch cleanup

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: [`git-master`]

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 4
  - **Blocks**: Task F3
  - **Blocked By**: Task 14

  **QA Scenarios**:
  ```
  Scenario: Cleanup removes worktree
    Tool: Bash
    Steps:
      1. omo worktree create temp-feature
      2. omo worktree cleanup temp-feature
      3. git worktree list
    Expected Result: temp-feature not in list
    Evidence: .sisyphus/evidence/task-17-cleanup.txt
  ```

  **Commit**: YES (groups with Task 15)

- [ ] 18. **Documentation**

  **What to do**:
  - Create `docs/worktree-guide.md`
  - Document all commands with examples
  - Add architecture diagram
  - Include troubleshooting section
  - Add to main README

  **Recommended Agent Profile**:
  - **Category**: `writing`
    - Reason: Documentation focus
  - **Skills**: []

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 4
  - **Blocks**: None
  - **Blocked By**: Task 15

  **Commit**: YES
  - Message: `docs(worktree): add user guide`

---
## Final Verification Wave

> 4 review agents run in PARALLEL. ALL must APPROVE.

- [ ] F1. **Plan Compliance Audit** — `oracle`
  Read the plan end-to-end. For each "Must Have": verify implementation exists. For each "Must NOT Have": search codebase for forbidden patterns. Check evidence files exist.
  Output: `Must Have [N/N] | Must NOT Have [N/N] | Tasks [N/N] | VERDICT: APPROVE/REJECT`

- [ ] F2. **Code Quality Review** — `unspecified-high`
  Run `tsc --noEmit` + linter + `bun test`. Review all changed files for: `as any`/`@ts-ignore`, empty catches, console.log in prod.
  Output: `Build [PASS/FAIL] | Lint [PASS/FAIL] | Tests [N pass/N fail] | VERDICT`

- [ ] F3. **Integration QA** — `deep`
  Test the complete workflow: create worktree → assign agent → run task → check status → merge → cleanup. Verify no file conflicts.
  Output: `Workflow [N/N steps pass] | Conflicts [0 detected] | VERDICT`

- [ ] F4. **Scope Fidelity Check** — `deep`
  Verify 1:1 — everything in spec was built, nothing beyond spec was built. Check "Must NOT do" compliance.
  Output: `Tasks [N/N compliant] | Scope Creep [NONE/N issues] | VERDICT`

---

## Commit Strategy

- **Wave 1**: `feat(worktree): add core infrastructure` — multiple files, bun test
- **Wave 2**: `feat(worktree): add CLI commands` — src/cli/worktree/*.ts, bun test
- **Wave 3**: `feat(worktree): add orchestration` — src/orchestrator/*.ts, bun test
- **Wave 4**: `feat(worktree): add integration and docs` — docs/, bun test

---

## Success Criteria

### Verification Commands
> **NOTE**: Run from `F:\\OpenOhMyCodePortable` using the portable bundle's CLI

```bash
# Create worktree with agent
omo worktree create feature-auth --agent sisyphus
# Expected: Worktree created at ../repo-feature-auth, agent started

# List all worktrees
omo worktree list
# Expected: Table showing worktree name, branch, agent, status

# Check status
omo worktree status feature-auth
# Expected: Agent progress, files modified, merge readiness

# Merge and cleanup
omo worktree merge feature-auth
# Expected: Changes merged to main, worktree cleaned up
```

### Final Checklist
- [ ] All "Must Have" features implemented
- [ ] All "Must NOT Have" avoided
- [ ] All tests pass
- [ ] Documentation complete
- [ ] No file conflicts in parallel execution
- [ ] Works on Windows without tmux
