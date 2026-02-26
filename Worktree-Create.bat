@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo.
echo ========================================
echo   OMO Worktree - Create New Worktree
echo ========================================
echo.

:: Get worktree name
set /p NAME="Enter worktree name (e.g., feature-auth): "
if "%NAME%"=="" (
    echo Error: Worktree name is required
    pause
    exit /b 1
)

:: Select agent
echo.
echo Available Agents:
echo   1. sisyphus          - Main orchestrator
echo   2. hephaestus        - Deep worker
echo   3. oracle            - Architecture/debugging
echo   4. librarian         - Documentation
echo   5. explore           - Code exploration
echo   6. frontend-ui-ux    - UI/UX design
echo   7. None (skip agent assignment)
echo.
set /p AGENT_NUM="Select agent (1-7): "

if "%AGENT_NUM%"=="1" set AGENT=--agent sisyphus
if "%AGENT_NUM%"=="2" set AGENT=--agent hephaestus
if "%AGENT_NUM%"=="3" set AGENT=--agent oracle
if "%AGENT_NUM%"=="4" set AGENT=--agent librarian
if "%AGENT_NUM%"=="5" set AGENT=--agent explore
if "%AGENT_NUM%"=="6" set AGENT=--agent frontend-ui-ux
if "%AGENT_NUM%"=="7" set AGENT=
if not defined AGENT_NUM set AGENT=

:: Optional branch name
echo.
set /p BRANCH="Branch name (leave empty for auto 'omo-%NAME%'): "
if not "%BRANCH%"=="" set BRANCH_OPT=--branch %BRANCH%

:: Execute
echo.
echo Creating worktree '%NAME%'...
echo.

call nodejs\node.exe app\node_modules\oh-my-opencode\dist\cli\index.js worktree create %NAME% %AGENT% %BRANCH_OPT%

echo.
pause
