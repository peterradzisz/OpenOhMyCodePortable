@echo off
REM OpenCode Usage Monitor - Summary
REM Shows token usage and cost estimates

setlocal enabledelayedexpansion

set APP_DIR=%~dp0
set DB_PATH=%USERPROFILE%\.local\share\opencode\opencode.db

echo.
echo ========================================
echo    OpenCode Usage Summary
echo ========================================
echo.

if not exist "%DB_PATH%" (
    echo Error: OpenCode database not found at:
    echo %DB_PATH%
    echo.
    echo Make sure you have used OpenCode at least once.
    pause
    exit /b 1
)

set DB_SIZE=
for %%A in ("%DB_PATH%") do set DB_SIZE=%%~zA
set /a DB_SIZE_MB=%DB_SIZE% / 1048576

echo Database: %DB_PATH%
echo Size: %DB_SIZE_MB% MB
echo.

echo Gathering statistics...
echo.

REM Query session count
for /f "delims=" %%i in ('"%APP_DIR%app\sqlite3.exe" "%DB_PATH%" "SELECT COUNT(*) FROM session;"') do set SESSION_COUNT=%%i

REM Query message count
for /f "delims=" %%i in ('"%APP_DIR%app\sqlite3.exe" "%DB_PATH%" "SELECT COUNT(*) FROM message;"') do set MSG_COUNT=%%i

echo Sessions: %SESSION_COUNT%
echo Messages: %MSG_COUNT%
echo.

REM Get token usage
echo Token Usage:
"%APP_DIR%app\sqlite3.exe" "%DB_PATH%" "SELECT 'Input:  ' || COALESCE(SUM(json_extract(data, '$.usage.input_tokens')), 0) as input_tokens FROM message WHERE data IS NOT NULL;"
"%APP_DIR%app\sqlite3.exe" "%DB_PATH%" "SELECT 'Output: ' || COALESCE(SUM(json_extract(data, '$.usage.output_tokens')), 0) as output_tokens FROM message WHERE data IS NOT NULL;"

echo.
echo ----------------------------------------
echo Recent Sessions:
echo ----------------------------------------
"%APP_DIR%app\sqlite3.exe" -column -header "%DB_PATH%" "SELECT substr(id, 1, 20) as ID, COALESCE(agent, 'default') as Agent, date(created_at/1000, 'unixepoch') as Date FROM session ORDER BY rowid DESC LIMIT 5;"

echo.
pause
