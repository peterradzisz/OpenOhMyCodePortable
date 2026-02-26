@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo.
echo ========================================
echo   OMO Worktree - Status Dashboard
echo ========================================
echo.

:: Ask if user wants to check for conflicts
set /p CONFLICTS="Check for file conflicts? (y/N): "
if /i "%CONFLICTS%"=="y" (
    set CONFLICT_OPT=--conflicts
)

echo.
call nodejs\node.exe app\node_modules\oh-my-opencode\dist\cli\index.js worktree status %CONFLICT_OPT%

echo.
pause
