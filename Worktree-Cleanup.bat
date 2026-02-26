@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo.
echo ========================================
echo   OMO Worktree - Cleanup Worktrees
echo ========================================
echo.

:: First list worktrees
echo Current worktrees:
echo.
call nodejs\node.exe app\node_modules\oh-my-opencode\dist\cli\index.js worktree list
echo.

:: Cleanup options
echo Cleanup Options:
echo   1. Remove specific worktree
echo   2. Remove all merged worktrees
echo   3. Remove ALL worktrees (dangerous!)
echo.
set /p CHOICE="Select option (1-3): "

if "%CHOICE%"=="1" (
    set /p NAME="Enter worktree name: "
    if "!NAME!"=="" (
        echo Error: Worktree name is required
        pause
        exit /b 1
    )
    set CMD=cleanup !NAME!
)

if "%CHOICE%"=="2" (
    set CMD=cleanup --merged
    echo.
    echo This will remove all merged worktrees.
)

if "%CHOICE%"=="3" (
    set CMD=cleanup --all
    echo.
    echo WARNING: This will remove ALL worktrees!
)

:: Confirm
echo.
set /p CONFIRM="Proceed? (y/N): "
if /i not "%CONFIRM%"=="y" (
    echo Cancelled.
    pause
    exit /b 0
)

:: Execute
echo.
call nodejs\node.exe app\node_modules\oh-my-opencode\dist\cli\index.js worktree %CMD%

echo.
pause
