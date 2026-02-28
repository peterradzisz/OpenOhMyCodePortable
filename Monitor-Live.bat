@echo off
REM OpenCode Usage Monitor - Live Watch
REM Watches for new messages in real-time

setlocal enabledelayedexpansion

set APP_DIR=%~dp0
set DB_PATH=%USERPROFILE%\.local\share\opencode\opencode.db

echo.
echo ========================================
echo    OpenCode Live Monitor
echo ========================================
echo.

if not exist "%DB_PATH%" (
    echo Error: OpenCode database not found.
    pause
    exit /b 1
)

REM Get initial count
for /f "delims=" %%i in ('"%APP_DIR%app\sqlite3.exe" "%DB_PATH%" "SELECT COUNT(*) FROM message;"') do set LAST_COUNT=%%i

echo Watching for new messages...
echo Starting with %LAST_COUNT% messages
echo.
echo Press Ctrl+C to stop
echo.
echo Time                 ^| Change ^| Total
echo ---------------------------------------------

:loop
timeout /t 2 /nobreak >nul 2>&1

for /f "delims=" %%i in ('"%APP_DIR%app\sqlite3.exe" "%DB_PATH%" "SELECT COUNT(*) FROM message;"') do set CURRENT_COUNT=%%i

if not "%CURRENT_COUNT%"=="%LAST_COUNT%" (
    set /a DIFF=%CURRENT_COUNT% - %LAST_COUNT%
    echo %time% ^| !DIFF! ^| %CURRENT_COUNT%
    set LAST_COUNT=%CURRENT_COUNT%
)

goto loop
