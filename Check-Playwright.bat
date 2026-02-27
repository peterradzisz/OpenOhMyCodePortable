@echo off
REM Check if Playwright Chromium is installed

setlocal
set "PORTABLE_ROOT=%~dp0"
if "%PORTABLE_ROOT:~-1%"=="\" set "PORTABLE_ROOT=%PORTABLE_ROOT:~0,-1%"

echo.
echo ========================================
echo   Playwright Status
echo ========================================
echo.

if exist "%PORTABLE_ROOT%\browsers\chromium-*" (
    echo [OK] Chromium browser is installed
    dir /b "%PORTABLE_ROOT%\browsers\chromium-*" 2>nul
) else (
    echo [MISSING] Chromium browser not found
    echo Run Install-Playwright.bat to install
)

echo.
if exist "%PORTABLE_ROOT%\app\node_modules\playwright" (
    echo [OK] Playwright npm package is installed
) else (
    echo [MISSING] Playwright npm package not found
    echo Run Install-Playwright.bat to install
)

echo.
echo PLAYWRIGHT_BROWSERS_PATH should be set to:
echo %PORTABLE_ROOT%\browsers
echo.
pause
