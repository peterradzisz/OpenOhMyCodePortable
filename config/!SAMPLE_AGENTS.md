# Sample Agent Configurations

This file contains example configurations for oh-my-opencode agents.

## Available Agents

| Agent | Category | Description | Best For |
|-------|----------|-------------|----------|
| **sisyphus** | Primary | Main orchestrator, drives tasks to completion | General work, coordination |
| **hephaestus** | Deep | Autonomous deep worker, end-to-end execution | Complex refactoring, research |
| **oracle** | Advisor | Architecture decisions, debugging | Hard problems, debugging |
| **librarian** | Utility | Documentation, knowledge management | Docs, research, examples |
| **explore** | Exploration | Codebase exploration and analysis | Understanding code, finding patterns |
| **metis** | Specialist | Planning and organization | Breaking down tasks |
| **momus** | Specialist | Quality assurance, critique | Code review, testing |
| **atlas** | Primary | Alternative orchestrator | Large-scale refactoring |
| **multimodal-looker** | Utility | Image and visual analysis | Screenshots, diagrams, UI |

---

## Configuration Examples

### Example 1: Budget-Friendly Setup (Cheap Models)

```json
{
  "agents": {
    "sisyphus": { "model": "deepseek/main" },
    "hephaestus": { "model": "deepseek/main" },
    "oracle": { "model": "groq/llama" },
    "librarian": { "model": "groq/llama" },
    "explore": { "model": "groq/llama" },
    "metis": { "model": "groq/llama" },
    "momus": { "model": "groq/llama" },
    "multimodal-looker": { "model": "google/flash" }
  }
}
```

### Example 2: Premium Setup (Best Models)

```json
{
  "agents": {
    "sisyphus": { "model": "anthropic/opus" },
    "hephaestus": { "model": "anthropic/opus" },
    "oracle": { "model": "anthropic/sonnet" },
    "librarian": { "model": "anthropic/haiku" },
    "explore": { "model": "anthropic/sonnet" },
    "metis": { "model": "anthropic/sonnet" },
    "momus": { "model": "anthropic/sonnet" },
    "multimodal-looker": { "model": "google/pro" }
  }
}
```

### Example 3: Local-Only Setup (Ollama)

```json
{
  "agents": {
    "sisyphus": { "model": "ollama/llama" },
    "hephaestus": { "model": "ollama/codellama" },
    "oracle": { "model": "ollama/llama" },
    "librarian": { "model": "ollama/llama" },
    "explore": { "model": "ollama/llama" },
    "metis": { "model": "ollama/llama" },
    "momus": { "model": "ollama/llama" },
    "multimodal-looker": { "model": "ollama/llama" }
  }
}
```

### Example 4: Mixed Provider Setup

```json
{
  "agents": {
    "sisyphus": { "model": "anthropic/sonnet" },
    "hephaestus": { "model": "deepseek/main" },
    "oracle": { "model": "anthropic/sonnet" },
    "librarian": { "model": "groq/llama" },
    "explore": { "model": "groq/llama" },
    "metis": { "model": "anthropic/haiku" },
    "momus": { "model": "anthropic/haiku" },
    "multimodal-looker": { "model": "google/pro" }
  }
}
```

### Example 5: Frontend-Focused Setup

```json
{
  "agents": {
    "sisyphus": { "model": "anthropic/sonnet" },
    "hephaestus": { "model": "anthropic/sonnet" },
    "oracle": { "model": "anthropic/sonnet" },
    "librarian": { "model": "anthropic/haiku" },
    "explore": { "model": "anthropic/sonnet" },
    "frontend-ui-ux": { "model": "anthropic/sonnet" },
    "multimodal-looker": { "model": "google/pro" }
  }
}
```

### Example 6: Code Review Focus

```json
{
  "agents": {
    "sisyphus": { "model": "anthropic/sonnet" },
    "momus": { "model": "anthropic/opus" },
    "oracle": { "model": "anthropic/sonnet" }
  }
}
```

---

## Model Provider Reference

### Anthropic Models
| Model ID | Name | Context | Best For |
|----------|------|---------|----------|
| `anthropic/opus` | Claude Opus 4 | 200K | Complex reasoning, architecture |
| `anthropic/sonnet` | Claude Sonnet 4 | 200K | Balanced performance |
| `anthropic/haiku` | Claude 3.5 Haiku | 200K | Fast, cheap tasks |

### OpenAI Models
| Model ID | Name | Context | Best For |
|----------|------|---------|----------|
| `openai/main` | GPT-4.1 | 128K | General purpose |
| `openai/mini` | GPT-4.1-mini | 128K | Faster, cheaper |
| `openai/nano` | GPT-4.1-nano | 128K | Simplest tasks |

### DeepSeek Models
| Model ID | Name | Context | Best For |
|----------|------|---------|----------|
| `deepseek/main` | DeepSeek Coder | 64K | Coding tasks |
| `deepseek/reasoner` | DeepSeek Reasoner | 64K | Complex reasoning |

### Groq Models (Fast)
| Model ID | Name | Context | Best For |
|----------|------|---------|----------|
| `groq/llama` | Llama 3.3 70B | 128K | Fast inference |
| `groq/qwen` | Qwen QwQ 32B | 128K | Reasoning |

### Google Models
| Model ID | Name | Context | Best For |
|----------|------|---------|----------|
| `google/pro` | Gemini 2.5 Pro | 1M | Large context, multimodal |
| `google/flash` | Gemini 2.5 Flash | 1M | Fast, efficient |

### Local Models (Ollama/LM Studio)
| Model ID | Name | Best For |
|----------|------|----------|
| `ollama/llama` | Llama 3.2 | General purpose |
| `ollama/codellama` | Code Llama | Coding |
| `ollama/qwen` | Qwen 2.5 Coder | Coding |
| `lmstudio/main` | Any loaded model | Flexible |

---

## When to Use Each Agent

### Sisyphus (Orchestrator)
- General task coordination
- Breaking down complex requests
- Driving tasks to completion
- **Avoid**: Simple single-file changes

### Hephaestus (Deep Worker)
- Complex refactoring
- Research + implementation
- End-to-end feature development
- **Avoid**: Quick fixes, documentation

### Oracle (Advisor)
- Architecture decisions
- Debugging complex issues
- Code review insights
- **Avoid**: Implementation work

### Librarian (Knowledge)
- Finding documentation
- Researching libraries
- Code examples
- **Avoid**: Writing production code

### Explore (Explorer)
- Understanding codebase structure
- Finding patterns in code
- Locating files/functions
- **Avoid**: Making changes

### Metis (Planner)
- Breaking down tasks
- Project organization
- Sprint planning
- **Avoid**: Direct implementation

### Momus (Critic)
- Code review
- Quality assurance
- Finding issues
- **Avoid**: Implementation work

### Multimodal-Looker (Visual)
- Analyzing screenshots
- Reading diagrams
- UI mockup analysis
- **Avoid**: Text-only tasks

---

## Tips

1. **Start with sonnet/haiku** - They're cheaper and often sufficient
2. **Use opus sparingly** - Reserve for complex architecture decisions
3. **Leverage Groq for speed** - Great for explore/librarian agents
4. **Use local models for privacy** - Ollama/LM Studio for sensitive code
5. **Mix providers** - Use different providers for different agent types
