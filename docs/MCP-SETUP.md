# MCP Server Setup Guide

This guide explains how to set up the required tokens for your MCP servers.

---

## Overview

Your `config/opencode.json` has 5 MCP servers configured:

| Server | Status | Action Needed |
|--------|--------|---------------|
| filesystem | ✅ Ready | None |
| memory | ✅ Ready | None |
| sqlite | ✅ Ready | None |
| github | ⚠️ Needs Token | Add GitHub PAT |
| supabase | ⚠️ Needs Token | Add Supabase token |

---

## GitHub Setup

### Step 1: Create a Personal Access Token

1. Go to: https://github.com/settings/tokens
2. Click **"Generate new token (classic)"**
3. Give it a name (e.g., "OpenOhMyCode Portable")
4. Select these scopes:
   - ✅ `repo` - Full control of private repositories
   - ✅ `read:org` - Read org and team membership
   - ✅ `workflow` - Update GitHub Action workflows (optional)
5. Click **"Generate token"**
6. **Copy the token** (you won't see it again!)

### Step 2: Add to Config

Edit `config/opencode.json` and replace the placeholder:

```json
"github": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxxxxxxxxxxxxxxxxx"
  }
}
```

---

## Supabase Setup

### Step 1: Get Your Access Token

1. Go to: https://supabase.com/dashboard/account/tokens
2. Click **"Generate new token"**
3. Give it a name (e.g., "OpenOhMyCode MCP")
4. Click **"Generate token"**
5. **Copy the token**

### Step 2: Add to Config

Edit `config/opencode.json` and replace the placeholder:

```json
"supabase": {
  "command": "npx",
  "args": ["-y", "@supabase/mcp-server-supabase"],
  "env": {
    "SUPABASE_ACCESS_TOKEN": "sbp_xxxxxxxxxxxxxxxxxxxx"
  }
}
```

---

## Testing Your Setup

### Test GitHub
```
List my recent GitHub repositories
```

### Test Supabase
```
Show me my Supabase projects
```

### Test SQLite
```
Query my opencode.db for recent sessions
```

### Test Memory
```
Remember that I use TypeScript for all new projects
```

### Test Filesystem
```
List all files in my portable folder
```

---

## Troubleshooting

### "npx not found"
- Make sure Node.js portable is properly set up
- Check that `nodejs/` folder exists in your portable root

### "GitHub API rate limit"
- Your token may be invalid or expired
- Regenerate the token and update config

### "Supabase unauthorized"
- Verify your access token is correct
- Check token hasn't been revoked

### MCP server won't start
- Check internet connection (npx downloads packages)
- Verify the package name is correct
- Try running `npx -y @modelcontextprotocol/server-filesystem --help` manually

---

## Security Notes

- **Never commit tokens to git** - Add `config/opencode.json` to `.gitignore`
- **Tokens are sensitive** - Treat them like passwords
- **Rotate tokens regularly** - Especially if you suspect they've been exposed
- **Use minimal scopes** - Only grant permissions you actually need
