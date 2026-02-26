# OpenOhMyCodePortable

NOT YET TESTED.

**Truly portable OpenCode + oh-my-opencode bundle for Windows.**

No installation required. No Node.js needed. Just extract and run!

## Quick Start

1. **Download**: Get the latest release ZIP
2. **Extract**: Unzip to any folder (USB drive, desktop, etc.)
3. **Configure**: Add your API keys to `config/opencode.json`
4. **Run**: Double-click `Start.bat`
5. **Select**: Pick your project folder
6. **Code**: OpenCode starts with oh-my-opencode agents!

## Configuration

### Step 1: Add Your API Keys

Open `config/opencode.json` and replace the placeholder API keys:

```json
{
  "provider": {
    "openai": {
      "apiKey": "YOUR_OPENAI_API_KEY_HERE"  ← Replace this
    },
    "anthropic": {
      "apiKey": "YOUR_ANTHROPIC_API_KEY_HERE"  ← Replace this
    }
  }
}
```

### Step 2: Choose Your Models (Optional)

Edit `config/oh-my-opencode.json` to set which model each agent uses:

```json
{
  "agents": {
    "explore": { "model": "anthropic/sonnet" },
    "oracle": { "model": "anthropic/sonnet" },
    "librarian": { "model": "anthropic/haiku" }
  }
}
```

## Supported Providers

| Provider | Models | Get API Key |
|----------|--------|-------------|
| **OpenAI** | GPT-4.1, GPT-4.1-mini, GPT-4.1-nano | [platform.openai.com](https://platform.openai.com) |
| **Anthropic** | Claude Opus 4, Sonnet 4, Haiku | [console.anthropic.com](https://console.anthropic.com) |
| **DeepSeek** | DeepSeek Coder, Reasoner | [platform.deepseek.com](https://platform.deepseek.com) |
| **Groq** | Llama 3.3, Qwen | [console.groq.com](https://console.groq.com) |
| **Google** | Gemini 2.5 Pro, Flash | [aistudio.google.com](https://aistudio.google.com) |
| **OpenRouter** | 100+ models | [openrouter.ai](https://openrouter.ai) |
| **Ollama** | Local models | [ollama.ai](https://ollama.ai) |
| **LM Studio** | Local models | [lmstudio.ai](https://lmstudio.ai) |

## What's Included

- **OpenCode** v1.2.14 - AI coding assistant CLI
- **oh-my-opencode** - Custom agents (explore, oracle, librarian, etc.)
- **Node.js** v22.14.0 - Portable runtime (no install needed)

## Bundle Size

~205 MB (includes all dependencies and binaries)

## Folder Structure

```
OpenOhMyCodePortable/
├── Start.bat                    # Double-click to launch
├── config/                      # Configuration files
│   ├── opencode.json            # API keys & providers
│   └── oh-my-opencode.json      # Agent model mappings
├── app/                         # Application files
│   └── node_modules/            # opencode-ai + oh-my-opencode
├── nodejs/                      # Portable Node.js runtime
└── README.md                    # This file
```

## oh-my-opencode Agents

| Agent | Description |
|-------|-------------|
| **explore** | Codebase exploration and analysis |
| **oracle** | Architecture decisions and debugging |
| **librarian** | Documentation and knowledge management |
| **sisyphus** | Continuous work execution |
| **frontend-ui-ux** | UI/UX design and implementation |
| **document-writer** | Documentation writing |
| **multimodal-looker** | Image and visual analysis |

## Portability

This bundle is **fully portable**:
- ✅ Copy to USB drive
- ✅ Run on any Windows machine
- ✅ No registry changes
- ✅ No system modifications
- ✅ Works offline with local models (Ollama/LM Studio)

## Requirements

- **Windows** 10/11 (x64)
- **No** Node.js installation needed
- **No** npm/bun needed

## Troubleshooting

### "Node.js not found"
Ensure the bundle is complete with the `nodejs` folder.

### "OpenCode not found"
Ensure the bundle is complete with the `app/node_modules` folder.

### "API key invalid"
Check that you've replaced the placeholder keys in `config/opencode.json`.

### PowerShell execution error
The launcher uses `-ExecutionPolicy Bypass` so this shouldn't happen.

## Updating

To update to a new version:
1. Download the new release
2. Replace all files
3. Copy your `config/` folder to keep settings

## License

- OpenCode: MIT
- oh-my-opencode: MIT
- Node.js: MIT
