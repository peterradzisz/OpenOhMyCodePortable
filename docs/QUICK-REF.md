# Quick Reference Card

## 🎯 Skills

| Skill | Purpose | Trigger |
|-------|---------|---------|
| `playwright` | Browser automation | Browser tasks |
| `playwright-cli` | Lightweight browser CLI | Simple browser tasks |
| `git-master` | Git operations | "commit", "rebase", "squash" |
| `frontend-ui-ux` | UI/UX design | Visual tasks |
| `dev-browser` | Browser with state | "go to", "click", "scrape" |

## 🔌 MCP Servers

| Server | Package | Ready? |
|--------|---------|--------|
| filesystem | `@modelcontextprotocol/server-filesystem` | ✅ |
| memory | `@modelcontextprotocol/server-memory` | ✅ |
| sqlite | `@modelcontextprotocol/server-sqlite` | ✅ |
| github | `@modelcontextprotocol/server-github` | ⚠️ Token |
| supabase | `@supabase/mcp-server-supabase` | ⚠️ Token |

## 🤖 Agents

| Agent | Role |
|-------|------|
| sisyphus | Main orchestrator |
| prometheus | Strategic planner |
| explore | Codebase search |
| oracle | Architecture/debug |
| librarian | Docs/knowledge |
| momus | Code review |
| frontend-ui-ux-engineer | UI implementation |
| document-writer | Documentation |
| multimodal-looker | Image analysis |

## 📁 File Locations

```
F:\OpenOhMyCodePortable\
├── config/
│   ├── opencode.json        ← MCP & providers
│   └── oh-my-opencode.json  ← Agents & skills
├── docs/
│   ├── SKILLS.md            ← Full skill docs
│   ├── MCP-SETUP.md         ← Token setup
│   └── QUICK-REF.md         ← This file
├── app/
│   ├── sqlite3.exe          ← SQLite CLI
│   └── node_modules/        ← Packages
├── nodejs/                  ← Portable Node.js
├── browsers/                ← Chromium
├── OpenOhMyCode.hta         ← Launcher
├── Monitor-*.bat            ← Monitoring scripts
└── Start.bat                ← Quick start
```

## ⌨️ Useful Commands

### Start OpenCode
```
.\Start.bat
```

### Monitor Usage
```
.\Monitor-Summary.bat
.\Monitor-Sessions.bat
.\Monitor-Live.bat
```

### Use Skills
```javascript
skill(name='playwright')
task(load_skills=['git-master'], prompt='...')
```

## 🔑 Token Setup

1. **GitHub**: https://github.com/settings/tokens
   - Scopes: `repo`, `read:org`
   
2. **Supabase**: https://supabase.com/dashboard/account/tokens

Edit `config/opencode.json` to add tokens.

## 🆘 Troubleshooting

| Problem | Solution |
|---------|----------|
| MCP won't start | Check internet, verify package name |
| Token error | Regenerate token, update config |
| Browser fails | Run "Install Chromium" in HTA |
| Skills not loading | Check oh-my-opencode in plugins |
