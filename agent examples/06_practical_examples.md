# AGENTS.md – Next.js E-Commerce Example

Source: [developertoolkit.ai](https://developertoolkit.ai/en/codex/quick-start/agents-md/)

## Stack

- Next.js 15 with App Router (NOT Pages Router).
- React Server Components by default. Use "use client" only when hooks are needed.
- Tailwind CSS with the project's design tokens in tailwind.config.ts.
- Zustand for client state. No Redux.

## Conventions

- Pages go in app/(routes)/ following the route group pattern.
- Shared components in components/ with .tsx extension.
- API routes in app/api/ -- each route in its own directory with route.ts.
- Use next/image for all images, never raw <img> tags.

## Testing

- `pnpm test` runs Vitest for unit tests.
- `pnpm test:e2e` runs Playwright for E2E tests.
- Every new page must have at least one Playwright test.

---

# AGENTS.md – FastAPI Python Service Example

Source: [developertoolkit.ai](https://developertoolkit.ai/en/codex/quick-start/agents-md/)

## Stack

- Python 3.12 with FastAPI and Pydantic v2.
- SQLAlchemy 2.0 with async sessions.
- Alembic for migrations.
- Poetry for dependency management.

## Commands

- `poetry run pytest` -- Run test suite.
- `poetry run ruff check .` -- Lint.
- `poetry run mypy .` -- Type check.
- `alembic upgrade head` -- Run migrations.

## Conventions

- All endpoints return Pydantic models, never raw dicts.
- Use dependency injection for database sessions.
- Async everywhere -- no sync database calls.
- Type hints required on all function signatures.

---

# AGENTS.md – Global/Personal Template

Source: [developertoolkit.ai](https://developertoolkit.ai/en/codex/quick-start/agents-md/)

Create at `~/.codex/AGENTS.md` for personal preferences across all projects.

## Development preferences

- Prefer pnpm over npm for package management.
- Always run tests after modifying source files.
- Ask for confirmation before adding new production dependencies.
- Use TypeScript strict mode in all new files.

## Git conventions

- Write conventional commit messages (feat:, fix:, chore:, etc.).
- Never force-push to main or master.
- Create feature branches for all changes.

## Code style

- Use single quotes for strings in JavaScript/TypeScript.
- Prefer async/await over raw promises.
- Add JSDoc comments to exported functions.

---

# AGENTS.md – Monorepo Example

Source: [developertoolkit.ai](https://developertoolkit.ai/en/codex/quick-start/agents-md/)

For monorepos, use nested AGENTS.md files:

```
myproject/
  AGENTS.md                    # Project-wide conventions
  packages/
    api/
      AGENTS.override.md        # API-specific rules
    frontend/
      AGENTS.md                 # Frontend-specific additions
    shared/
      AGENTS.md                 # Shared library conventions
```

### API Package Override Example

```markdown
# API Service Overrides

## Testing
- Use `make test-api` instead of `pnpm test`.
- Integration tests require a running PostgreSQL container.
- Run `docker-compose up -d db` before running tests.

## Security
- Never rotate API keys without notifying the #security Slack channel.
- All new endpoints must be added to the OpenAPI spec before implementation.
```
