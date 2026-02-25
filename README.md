# OpenOhMyCodePortable

A simple portable launcher for OpenCode that lets you pick a project folder via GUI instead of using command line.

## Quick Start

1. **Download**: Click the green "Code" button → "Download ZIP"
2. **Extract**: Unzip the file
3. **Run**: Double-click `OpenOhMyCodePortable.bat`
4. **Select**: Pick your project folder
5. **Code**: OpenCode starts in that folder!

## Requirements

- **OpenCode installed globally**:
  ```bash
  npm install -g opencode-ai
  # OR
  bun add -g opencode-ai
  ```

## Features

- 📁 **Folder Picker** - Select any folder via native Windows dialog
- 🚀 **Portable** - No installation needed, just double-click
- 🔧 **Optional Setup** - Can copy your oh-my-opencode config to the project

## Usage

### Basic
```
Double-click OpenOhMyCodePortable.bat
```

### With oh-my-opencode setup
```
OpenOhMyCodePortable.bat -InstallOhMyOpenCode
```

## Files

| File | Description |
|------|-------------|
| `OpenOhMyCodePortable.bat` | Double-click to run |
| `OpenOhMyCodePortable.ps1` | PowerShell script (optional) |

## Troubleshooting

### "OpenCode is not installed"
```bash
npm install -g opencode-ai
```

### PowerShell error
Run as administrator or enable scripts:
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

## License

MIT
