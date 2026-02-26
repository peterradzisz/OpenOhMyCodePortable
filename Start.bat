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
set "PATH=%PORTABLE_ROOT%\bin;%NODE_HOME%;%APP_HOME%\node_modules\.bin;%PATH%"

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
    echo.
    echo ERROR: Node.js not found at %NODE_HOME%\node.exe
    echo Please ensure the portable bundle is complete.
    echo.
    pause
    exit /b 1
)

REM Check if opencode exists
if not exist "%APP_HOME%\node_modules\opencode-ai\bin\opencode" (
    echo.
    echo ERROR: OpenCode not found.
    echo Looking for: %APP_HOME%\node_modules\opencode-ai\bin\opencode
    echo Please ensure the portable bundle is complete.
    echo.
    pause
    exit /b 1
)

:menu
echo.
echo Select an option:
echo.
echo   1. Run OpenCode (enter project path)
echo   2. Run OpenCode in current folder
echo   3. Open Worktree Menu
echo   4. Exit
echo.
set /p CHOICE="Enter choice (1-4): "

if "%CHOICE%"=="1" goto manual_path
if "%CHOICE%"=="2" goto current_folder
if "%CHOICE%"=="3" goto worktree_menu
if "%CHOICE%"=="4" goto end

echo Invalid choice. Please try again.
goto menu

:manual_path
echo.
echo Enter the full path to your project folder.
echo Example: C:\Users\YourName\Projects\my-project
echo.
set /p PROJECT_FOLDER="Project path: "

REM Remove quotes if present
set PROJECT_FOLDER=%PROJECT_FOLDER:"=%

if "%PROJECT_FOLDER%"=="" (
    echo No path entered.
    goto menu
)

if not exist "%PROJECT_FOLDER%" (
    echo.
    echo ERROR: Folder not found: %PROJECT_FOLDER%
    echo Please check the path and try again.
    goto menu
)

goto run_opencode

:current_folder
set "PROJECT_FOLDER=%PORTABLE_ROOT%"
goto run_opencode

:worktree_menu
call "%PORTABLE_ROOT%\Worktree-Menu.bat"
goto menu

:run_opencode
echo.
echo Selected folder: %PROJECT_FOLDER%
echo.
echo Starting OpenCode...
echo.

REM Change to selected folder and run opencode
cd /d "%PROJECT_FOLDER%"

REM Run opencode using our portable Node.js
"%NODE_HOME%\node.exe" "%APP_HOME%\node_modules\opencode-ai\bin\opencode" %*

REM Capture exit code
set EXIT_CODE=%ERRORLEVEL%

echo.
if %EXIT_CODE% neq 0 (
    echo OpenCode exited with error code: %EXIT_CODE%
    echo.
)

echo Press any key to return to menu...
pause >nul
goto menu

:end
echo.
echo Goodbye!
endlocal
exit /b 0
