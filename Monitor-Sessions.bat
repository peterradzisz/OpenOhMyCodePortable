@echo off
REM OpenCode Usage Monitor - Session List
REM Lists recent OpenCode sessions

setlocal enabledelayedexpansion

set APP_DIR=%~dp0
set DB_PATH=%USERPROFILE%\.local\share\opencode\opencode.db

echo.
echo ========================================
echo    OpenCode Sessions
echo ========================================
echo.

if not exist "%DB_PATH%" (
    echo Error: OpenCode database not found.
    pause
    exit /b 1
)

"%APP_DIR%app\sqlite3.exe" -column -header "%DB_PATH%" "SELECT substr(s.id, 1, 25) as ID, COALESCE(s.agent, 'default') as Agent, (SELECT COUNT(*) FROM message m WHERE m.session_id = s.id) as Msgs, date(s.created_at/1000, 'unixepoch') as Date FROM session s ORDER BY s.rowid DESC LIMIT 20;"

echo.
pause
