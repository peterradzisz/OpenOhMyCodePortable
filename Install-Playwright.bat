@echo off
REM OpenOhMyCodePortable - Playwright Chromium Installer
REM Downloads and installs Playwright with Chromium browser (~135MB)

setlocal EnableDelayedExpansion

REM Get the directory where this script is located
set "PORTABLE_ROOT=%~dp0"
if "%PORTABLE_ROOT:~-1%"=="\" set "PORTABLE_ROOT=%PORTABLE_ROOT:~0,-1%"

REM Set up paths
set "NODE_HOME=%PORTABLE_ROOT%\nodejs"
set "APP_HOME=%PORTABLE_ROOT%\app"
set "PLAYWRIGHT_BROWSERS_PATH=%PORTABLE_ROOT%\browsers"
set "PATH=%NODE_HOME%;%APP_HOME%\node_modules\.bin;%PATH%"

echo.
echo ========================================
echo   Playwright Chromium Installer
echo ========================================
echo.
echo This will download Playwright with Chromium.
echo Download size: ~135MB
echo.
echo Install location: %PLAYWRIGHT_BROWSERS_PATH%
echo.

REM Check if Node.js exists
if not exist "%NODE_HOME%\node.exe" (
    echo ERROR: Node.js not found at %NODE_HOME%\node.exe
    pause
    exit /b 1
)

set /p CONFIRM="Continue? (y/N): "
if /i not "%CONFIRM%"=="y" (
    echo Cancelled.
    pause
    exit /b 0
)

echo.
echo [1/3] Setting environment variables...
set "PLAYWRIGHT_BROWSERS_PATH=%PORTABLE_ROOT%\browsers"

echo.
echo [2/3] Installing Playwright npm package...
cd /d "%APP_HOME%"

REM Install playwright in the app folder
"%NODE_HOME%\npm.cmd" install playwright --save --no-save --ignore-scripts 2>nul
if %ERRORLEVEL% neq 0 (
    echo.
    echo Installing with npm directly...
    "%NODE_HOME%\node.exe" "%NODE_HOME%\node_modules\npm\bin\npm-cli.js" install playwright --prefix "%APP_HOME%" --no-save
)

echo.
echo [3/3] Downloading Chromium browser (~135MB)...
echo This may take a few minutes...
echo.

REM Run playwright install chromium
"%NODE_HOME%\node.exe" -e "process.env.PLAYWRIGHT_BROWSERS_PATH='%PLAYWRIGHT_BROWSERS_PATH%'; require('child_process').spawnSync('node', [require.resolve('playwright/cli'), 'install', 'chromium'], {stdio: 'inherit', cwd: '%APP_HOME%'})"

if %ERRORLEVEL% neq 0 (
    echo.
    echo Trying alternative method...
    cd /d "%APP_HOME%\node_modules\playwright"
    set "PLAYWRIGHT_BROWSERS_PATH=%PORTABLE_ROOT%\browsers"
    "%NODE_HOME%\node.exe" cli.js install chromium
)

echo.
echo ========================================
if exist "%PLAYWRIGHT_BROWSERS_PATH%\chromium-*" (
    echo SUCCESS: Playwright Chromium installed!
    echo.
    echo Browser location: %PLAYWRIGHT_BROWSERS_PATH%
    echo.
    echo To use in your code:
    echo   set PLAYWRIGHT_BROWSERS_PATH=%PORTABLE_ROOT%\browsers
) else (
    echo Installation may have issues. Check the output above.
)
echo ========================================
echo.
pause
