@echo off
setlocal
cd /d "%~dp0"

echo.
echo ========================================
echo   OMO Worktree - List All Worktrees
echo ========================================
echo.

call nodejs\node.exe app\node_modules\oh-my-opencode\dist\cli\index.js worktree list

echo.
pause
