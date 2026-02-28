# OpenOhMyCode Portable - Skills & MCP Servers

This document describes all available skills and MCP servers in your portable bundle.

---

## Built-in Skills (from oh-my-opencode)

These skills are bundled with oh-my-opencode and ready to use:

### playwright
**Purpose**: Browser automation via MCP

**Features**:
- Navigate to URLs
- Click elements, fill forms
- Take screenshots
- Extract page content
- Handle multiple pages/tabs

**Requirements**: Chromium browser (already installed in `browsers/` folder)

**Usage**: Agents automatically use this when browser tasks are needed

---

### playwright-cli
**Purpose**: Lightweight CLI alternative to Playwright MCP

**Features**:
- Token-efficient browser automation
- CLI-based interaction
- No MCP overhead

**Usage**: Alternative to full Playwright when you need simpler browser tasks

---

### git-master
**Purpose**: Advanced Git operations

**Features**:
- Atomic commits with proper messages
- Rebase and squash operations
- History search (blame, bisect, log -S)
- Branch management

**Trigger phrases**: "commit", "rebase", "squash", "who wrote", "when was X added"

**Usage**: 
```
task(category='quick', load_skills=['git-master'], ...)
```

---

### frontend-ui-ux
**Purpose**: UI/UX design and implementation

**Features**:
- Design-first UI approach
- Creates stunning interfaces without mockups
- Responsive design
- Accessibility considerations

**Usage**: Automatically used for visual-engineering category tasks

---

### dev-browser
**Purpose**: Browser automation with persistent page state

**Features**:
- Navigate websites
- Fill forms
- Take screenshots
- Extract web data
- Test web apps
- Automate browser workflows

**Trigger phrases**: "go to [url]", "click on", "fill out the form", "take a screenshot", "scrape", "automate", "test the website", "log into"

---

## Configured MCP Servers

These MCP servers are configured in `config/opencode.json`:

### filesystem
**Package**: `@modelcontextprotocol/server-filesystem`

**Purpose**: Access and manage files in specified directories

**Configured Path**: `F:/OpenOhMyCodePortable`

**Features**:
- Read/write files
- List directories
- Create/delete files and folders
- Search within allowed paths

---

### github
**Package**: `@modelcontextprotocol/server-github`

**Purpose**: GitHub API integration

**Features**:
- Create/manage repositories
- Create/update issues and pull requests
- Search code across GitHub
- Manage branches and commits
- Access GitHub Actions

**Required Setup**:
1. Create a Personal Access Token at https://github.com/settings/tokens
2. Required scopes: `repo`, `read:org`
3. Update `config/opencode.json`:
   ```json
   "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your_token_here"
   ```

---

### memory
**Package**: `@modelcontextprotocol/server-memory`

**Purpose**: Knowledge base and vector storage

**Features**:
- Store and retrieve information
- Build knowledge graphs
- Remember preferences and context
- Semantic search

**Usage**:
```
Remember that I prefer TypeScript for new projects
What do you know about my coding preferences?
```

---

### sqlite
**Package**: `@modelcontextprotocol/server-sqlite`

**Purpose**: Query local SQLite databases

**Features**:
- Execute SQL queries on .db files
- Inspect database schemas
- Query your opencode.db (session history, messages)
- Analyze local data

**Example Databases**:
- `~/.local/share/opencode/opencode.db` - OpenCode session data
- Any local `.db` files in your projects

---

### supabase
**Package**: `@supabase/mcp-server-supabase`

**Purpose**: Connect to Supabase cloud projects

**Features**:
- Manage tables and data
- Query remote databases
- Access edge functions
- Manage storage buckets
- Authentication management

**Required Setup**:
1. Get your Supabase access token from https://supabase.com/dashboard
2. Update `config/opencode.json`:
   ```json
   "SUPABASE_ACCESS_TOKEN": "your_supabase_token_here"
   ```

---

## Built-in MCPs (from oh-my-opencode)

These MCPs are automatically available through oh-my-opencode:

### websearch (Exa)
**Purpose**: Web search capabilities

**Features**:
- Search the web for current information
- Get clean, LLM-optimized results
- Live crawling support

---

### context7
**Purpose**: Official documentation search

**Features**:
- Query official library documentation
- Get up-to-date API references
- Code examples

---

### grep_app
**Purpose**: GitHub code search

**Features**:
- Search code across 1M+ GitHub repositories
- Find real-world code examples
- Pattern-based search

---

## How to Use Skills

### Method 1: Automatic (by Agent)
Agents automatically select appropriate skills based on task type:
- Visual tasks → `playwright`, `frontend-ui-ux`
- Git operations → `git-master`
- Browser tasks → `dev-browser`, `playwright`

### Method 2: Explicit (via task tool)
```javascript
task(
  category='quick',
  load_skills=['git-master'],
  prompt='Create an atomic commit for these changes'
)
```

### Method 3: Via skill() function
```javascript
skill(name='playwright')
```

---

## Available Agents

These agents are configured in `oh-my-opencode.json`:

| Agent | Purpose |
|-------|---------|
| **default** | Main agent for general tasks |
| **explore** | Codebase exploration and analysis |
| **oracle** | Architecture decisions and debugging |
| **librarian** | Documentation and knowledge management |
| **sisyphus** | Continuous work execution (main orchestrator) |
| **prometheus** | Strategic planning (interview mode) |
| **momus** | Code review and quality |
| **frontend-ui-ux-engineer** | UI/UX implementation |
| **document-writer** | Documentation writing |
| **multimodal-looker** | Image and visual analysis |

---

## Adding More Skills

### Option 1: Custom Skills Directory
Create skills in:
- Project: `.opencode/skills/*/SKILL.md`
- User: `~/.config/opencode/skills/*/SKILL.md`

### Option 2: Add MCP Servers
Edit `config/opencode.json`:
```json
"mcp": {
  "my-server": {
    "command": "npx",
    "args": ["-y", "@my-org/mcp-server"]
  }
}
```

---

## Troubleshooting

### MCP Server Not Starting
- Ensure `npx` can reach the npm registry
- Check if the package name is correct
- Verify environment variables are set

### Skills Not Loading
- Check oh-my-opencode is in the plugin list
- Verify skill is not disabled in config
- Check for syntax errors in config files

### Browser Automation Fails
- Ensure Chromium is installed (`browsers/` folder)
- Run "Install Chromium" from HTA Playwright panel

---

## Quick Reference

| What you want | What to use |
|---------------|-------------|
| Search the web | `websearch` (built-in) |
| Official docs | `context7` (built-in) |
| GitHub code | `grep_app` (built-in) |
| Browser automation | `playwright` or `dev-browser` |
| Git operations | `git-master` |
| UI/UX design | `frontend-ui-ux` |
| File access | `filesystem` MCP |
| GitHub API | `github` MCP |
| Remember things | `memory` MCP |
| Local SQLite | `sqlite` MCP |
| Supabase cloud | `supabase` MCP |
