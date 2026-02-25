@echo off
REM OpenOhMyCodePortable - Batch wrapper
REM Double-click this file to launch OpenCode with folder picker

setlocal

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"

REM Change to script directory
cd /d "%SCRIPT_DIR%"

REM Run PowerShell with the launcher script
REM -ExecutionPolicy Bypass allows running without changing system policy
REM -NoProfile speeds up startup
powershell -ExecutionPolicy Bypass -NoProfile -File "%SCRIPT_DIR%OpenOhMyCodePortable.ps1" %*

if errorlevel 1 (
    echo.
    echo Press any key to exit...
    pause >nul
)

endlocal
