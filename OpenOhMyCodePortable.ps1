# OpenOhMyCodePortable.ps1
# A portable launcher for OpenCode with folder picker
# Just double-click or run this script, select a folder, and opencode starts there

param(
    [switch]$InstallOhMyOpenCode,
    [switch]$SkipOpenCode
)

$ErrorActionPreference = "Stop"

# Get script directory for relative paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Function to check if opencode is installed
function Test-OpenCodeInstalled {
    try {
        $null = Get-Command opencode -ErrorAction SilentlyContinue
        return $true
    } catch {
        return $false
    }
}

# Function to show folder picker dialog
function Show-FolderPicker {
    Add-Type -AssemblyName System.Windows.Forms
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = "Select your project folder to run OpenCode"
    $dialog.ShowNewFolderButton = $false
    $dialog.UseDescriptionForTitle = $true
    
    # Try to start in common locations
    $dialog.InitialDirectory = [Environment]::GetFolderPath("Desktop")
    
    $result = $dialog.ShowDialog()
    
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $dialog.SelectedPath
    }
    return $null
}

# Function to setup oh-my-opencode in selected folder
function Install-OhMyOpenCodeInFolder {
    param([string]$FolderPath)
    
    $configPath = Join-Path $env:USERPROFILE ".config\opencode\opencode.json"
    
    if (Test-Path $configPath) {
        Write-Host "Found existing opencode config at: $configPath" -ForegroundColor Cyan
        $copy = Read-Host "Copy your existing config to this project folder? (Y/n)"
        if ($copy -ne "n" -and $copy -ne "N") {
            $localConfig = Join-Path $FolderPath "opencode-project.json"
            Copy-Item $configPath $localConfig -Force
            Write-Host "Config copied to: $localConfig" -ForegroundColor Green
        }
    }
    
    $ohMyConfig = Join-Path $env:USERPROFILE ".config\opencode\oh-my-opencode.json"
    if (Test-Path $ohMyConfig) {
        Write-Host "Found existing oh-my-opencode config" -ForegroundColor Cyan
        $copy = Read-Host "Copy oh-my-opencode config to this project folder? (Y/n)"
        if ($copy -ne "n" -or $copy -ne "N") {
            $localOhMyConfig = Join-Path $FolderPath "oh-my-opencode.json"
            Copy-Item $ohMyConfig $localOhMyConfig -Force
            Write-Host "oh-my-opencode config copied to: $localOhMyConfig" -ForegroundColor Green
        }
    }
}

# Main execution
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  OpenOhMyCode Portable Launcher" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if opencode is installed
if (-not (Test-OpenCodeInstalled)) {
    Write-Host "ERROR: OpenCode is not installed or not in PATH" -ForegroundColor Red
    Write-Host ""
    Write-Host "To install OpenCode, run:" -ForegroundColor Yellow
    Write-Host "  npm install -g opencode-ai" -ForegroundColor White
    Write-Host "  # OR" -ForegroundColor White
    Write-Host "  bun add -g opencode-ai" -ForegroundColor White
    Write-Host ""
    Write-Host "NOTE: This launcher requires OpenCode to be installed globally." -ForegroundColor Yellow
    Write-Host "The launcher itself just helps you select a folder." -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}

Write-Host "OpenCode found: $(Get-Command opencode | Select-Object -ExpandProperty Source)" -ForegroundColor Green
Write-Host ""

# Show folder picker
$selectedFolder = Show-FolderPicker

if (-not $selectedFolder) {
    Write-Host "No folder selected. Exiting." -ForegroundColor Yellow
    exit 0
}

Write-Host "Selected folder: $selectedFolder" -ForegroundColor Green
Write-Host ""

# Handle oh-my-opencode setup
if ($InstallOhMyOpenCode) {
    Install-OhMyOpenCodeInFolder -FolderPath $selectedFolder
}

# Check if we should skip running opencode (just for setup)
if ($SkipOpenCode) {
    Write-Host "Setup complete. Not starting OpenCode." -ForegroundColor Yellow
    exit 0
}

# Change to selected folder and run opencode
Write-Host "Starting OpenCode in: $selectedFolder" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Ctrl+C to cancel..." -ForegroundColor Gray
Start-Sleep -Seconds 2

try {
    Set-Location $selectedFolder
    opencode
} catch {
    Write-Host ""
    Write-Host "ERROR: Failed to run OpenCode" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    pause
    exit 1
}
