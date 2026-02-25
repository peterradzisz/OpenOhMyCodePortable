@echo off
REM OpenOhMyCodePortable - Portable OpenCode + oh-my-opencode Launcher
REM Just double-click to run - no installation needed!

setlocal EnableDelayedExpansion

REM Get the directory where this script is located
set "PORTABLE_ROOT=%~dp0"
if "%PORTABLE_ROOT:~-1%"=="\" set "PORTABLE_ROOT=%PORTABLE_ROOT:~0,-1%"

REM Set up paths to use portable Node.js
set "NODE_HOME=%PORTABLE_ROOT%\nodejs"
set "APP_HOME=%PORTABLE_ROOT%\app"
set "PATH=%NODE_HOME%;%APP_HOME%\node_modules\.bin;%PATH%"

REM Set Node.js to use local modules
set "NODE_PATH=%APP_HOME%\node_modules"

REM Set npm global prefix to our app folder (so plugins install there)
set "NPM_CONFIG_PREFIX=%APP_HOME%"

REM Set OpenCode config directory (portable)
set "OPENCODE_CONFIG_DIR=%PORTABLE_ROOT%\config"

echo.
echo ========================================
echo   OpenOhMyCode Portable
echo ========================================
echo.
echo Portable Node.js: %NODE_HOME%
echo App Directory: %APP_HOME%
echo Config Directory: %OPENCODE_CONFIG_DIR%
echo.

REM Check if Node.js exists
if not exist "%NODE_HOME%\node.exe" (
    echo ERROR: Node.js not found at %NODE_HOME%\node.exe
    echo Please ensure the portable bundle is complete.
    pause
    exit /b 1
)

REM Check if opencode exists
if not exist "%APP_HOME%\node_modules\opencode-ai\bin\opencode" (
    echo ERROR: OpenCode not found.
    echo Please ensure the portable bundle is complete.
    pause
    exit /b 1
)

REM Show folder picker using PowerShell
echo Select your project folder...
for /f "delims=" %%i in ('powershell -ExecutionPolicy Bypass -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $dialog = New-Object System.Windows.Forms.FolderBrowserDialog; $dialog.Description = 'Select your project folder to run OpenCode'; $dialog.ShowNewFolderButton = $false; $dialog.UseDescriptionForTitle = $true; $dialog.InitialDirectory = [Environment]::GetFolderPath('Desktop'); if ($dialog.ShowDialog() -eq 'OK') { $dialog.SelectedPath } else { '' }"') do set "PROJECT_FOLDER=%%i"

REM Check if folder was selected
if "%PROJECT_FOLDER%"=="" (
    echo No folder selected. Exiting.
    exit /b 0
)

echo.
echo Selected folder: %PROJECT_FOLDER%
echo.
echo Starting OpenCode...
echo.

REM Change to selected folder and run opencode
cd /d "%PROJECT_FOLDER%"

REM Run opencode using our portable Node.js
"%NODE_HOME%\node.exe" "%APP_HOME%\node_modules\opencode-ai\bin\opencode" %*

endlocal
