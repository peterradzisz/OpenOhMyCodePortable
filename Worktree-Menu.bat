@echo off
setlocal
cd /d "%~dp0"

:menu
cls
echo.
echo  ╔══════════════════════════════════════════════════════════╗
echo  ║         OMO WORKTREE - Parallel Agent Manager            ║
echo  ╠══════════════════════════════════════════════════════════╣
echo  ║                                                          ║
echo  ║   Worktrees allow multiple AI agents to work in         ║
echo  ║   parallel on different branches without conflicts.      ║
echo  ║                                                          ║
echo  ╠══════════════════════════════════════════════════════════╣
echo  ║  1. Create Worktree    - Start new parallel work         ║
echo  ║  2. List Worktrees     - See all worktrees               ║
echo  ║  3. Status Dashboard   - View status and conflicts       ║
echo  ║  4. Merge Worktree     - Merge completed work            ║
echo  ║  5. Cleanup Worktrees  - Remove worktrees                ║
echo  ║                                                          ║
echo  ║  H. Help               - Learn more                      ║
echo  ║  Q. Quit               - Exit                            ║
echo  ║                                                          ║
echo  ╚══════════════════════════════════════════════════════════╝
echo.

set /p CHOICE="Select option (1-5, H, Q): "

if /i "%CHOICE%"=="1" goto create
if /i "%CHOICE%"=="2" goto list
if /i "%CHOICE%"=="3" goto status
if /i "%CHOICE%"=="4" goto merge
if /i "%CHOICE%"=="5" goto cleanup
if /i "%CHOICE%"=="H" goto help
if /i "%CHOICE%"=="Q" goto quit
if /i "%CHOICE%"=="q" goto quit

echo.
echo Invalid option. Press any key to try again...
pause >nul
goto menu

:create
call Worktree-Create.bat
goto menu

:list
call Worktree-List.bat
goto menu

:status
call Worktree-Status.bat
goto menu

:merge
call Worktree-Merge.bat
goto menu

:cleanup
call Worktree-Cleanup.bat
goto menu

:help
cls
echo.
echo  ╔══════════════════════════════════════════════════════════╗
echo  ║                    WORKTREE HELP                         ║
echo  ╚══════════════════════════════════════════════════════════╝
echo.
echo  WHAT ARE WORKTREES?
echo  -------------------
echo  Git worktrees let you check out multiple branches at once.
echo  Each worktree is its own folder where an AI agent can work
echo  independently without affecting other work.
echo.
echo  WORKFLOW:
echo  ---------
echo  1. CREATE - Make a new worktree and assign an agent
echo  2. WORK   - The agent works in isolation
echo  3. MERGE  - When done, merge the changes back
echo  4. CLEANUP - Remove the worktree
echo.
echo  AVAILABLE AGENTS:
echo  -----------------
echo   sisyphus       - Main orchestrator, drives tasks to completion
echo   hephaestus     - Deep autonomous worker
echo   oracle         - Architecture and debugging
echo   librarian      - Documentation
echo   explore        - Code exploration
echo   frontend-ui-ux - UI/UX design
echo.
echo  STATUS ICONS:
echo  ------------
echo   [+] Created    [~] Active    [-] Idle
echo   [M] Merged     [x] Cleaned
echo.
echo   [.] Pending    [^>] Running    [ok] Completed    [!] Failed
echo.
echo  Press any key to return to menu...
pause >nul
goto menu

:quit
echo.
echo Goodbye!
exit /b 0
