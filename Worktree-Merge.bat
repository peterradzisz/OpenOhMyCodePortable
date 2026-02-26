@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo.
echo ========================================
echo   OMO Worktree - Merge Worktree
echo ========================================
echo.

:: First list worktrees
echo Current worktrees:
echo.
call nodejs\node.exe app\node_modules\oh-my-opencode\dist\cli\index.js worktree list
echo.

:: Get worktree name
set /p NAME="Enter worktree name to merge: "
if "%NAME%"=="" (
    echo Error: Worktree name is required
    pause
    exit /b 1
)

:: Options
echo.
echo Merge Options:
echo.

set /p SQUASH="Squash commits into one? (y/N): "
if /i "%SQUASH%"=="y" set SQUASH_OPT=--squash

set /p KEEP="Keep worktree after merge? (y/N): "
if /i "%KEEP%"=="y" set KEEP_OPT=--keep-worktree

set /p MESSAGE="Commit message (leave empty for auto): "
if not "%MESSAGE%"=="" set MSG_OPT=--message "%MESSAGE%"

:: Confirm
echo.
echo About to merge worktree '%NAME%'
if defined SQUASH_OPT echo   - Squash: Yes
if defined KEEP_OPT echo   - Keep worktree: Yes
echo.
set /p CONFIRM="Proceed? (y/N): "
if /i not "%CONFIRM%"=="y" (
    echo Cancelled.
    pause
    exit /b 0
)

:: Execute
echo.
call nodejs\node.exe app\node_modules\oh-my-opencode\dist\cli\index.js worktree merge %NAME% %SQUASH_OPT% %KEEP_OPT% %MSG_OPT% --yes

echo.
pause
