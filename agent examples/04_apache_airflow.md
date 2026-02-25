# AGENTS.md – Apache Airflow (Python Monorepo)

Source: [apache/airflow/AGENTS.md](https://github.com/apache/airflow/blob/main/AGENTS.md)

## Environment Setup

- Install prek: `uv tool install prek`
- Enable commit hooks: `prek install`
- **Never run pytest, python, or airflow commands directly on the host** — always use `breeze`.
- Place temporary scripts in `dev/` (mounted as `/opt/airflow/dev/` inside Breeze).

## Commands

- **Run a single test:** `breeze run pytest path/to/test.py::TestClass::test_method -xvs`
- **Run a test file:** `breeze run pytest path/to/test.py -xvs`
- **Run a Python script:** `breeze run python dev/my_script.py`
- **Run Airflow CLI:** `breeze run airflow dags list`
- **Type-check:** `breeze run mypy path/to/code`
- **Lint/format:** `prek run --all-files`
- **Build docs:** `breeze build-docs`

SQLite is the default backend. Use `--backend postgres` or `--backend mysql` for integration tests.

## Repository Structure

UV workspace monorepo. Key paths:

- `airflow-core/src/airflow/` — core scheduler, API, CLI, models
  - `models/` — SQLAlchemy models (DagModel, TaskInstance, DagRun, Asset, etc.)
  - `jobs/` — scheduler, triggerer, Dag processor runners
  - `api_fastapi/core_api/` — public REST API v2
  - `api_fastapi/execution_api/` — task execution communication API
  - `dag_processing/` — Dag parsing and validation
  - `cli/` — command-line interface
  - `ui/` — React/TypeScript web interface (Vite)
- `task-sdk/` — lightweight SDK for Dag authoring
- `providers/` — 100+ provider packages
- `chart/` — Helm chart for Kubernetes

## Architecture Boundaries

1. Users author Dags with the Task SDK (`airflow.sdk`).
2. Dag Processor parses Dag files in isolated processes.
3. Scheduler reads serialized Dags — **never runs user code**.
4. Workers execute tasks via Task SDK.
5. API Server serves the React UI and handles client-database interactions.
6. Triggerer evaluates deferred tasks/sensors in isolated processes.

## Coding Standards

- No `assert` in production code.
- `time.monotonic()` for durations, not `time.time()`.
- In `airflow-core`, functions with a `session` parameter must not call `session.commit()`.
- Imports at top of file. Valid exceptions: circular imports, lazy loading for worker isolation, `TYPE_CHECKING` blocks.
- Guard heavy type-only imports with `TYPE_CHECKING`.
- Apache License header on all new files.

## Testing Standards

- Add tests for new behavior — cover success, failure, and edge cases.
- Use pytest patterns, not `unittest.TestCase`.
- Use `spec`/`autospec` when mocking.
- Use `@pytest.mark.parametrize` for multiple similar inputs.
- Test location mirrors source: `airflow/cli/cli_parser.py` → `tests/cli/test_cli_parser.py`.

## Commits and PRs

- **Good:** `Fix airflow dags test command failure without serialized Dags`
- **Bad:** `Initialize DAG bundles in CLI get_dag function`

Add a newsfragment for user-visible changes:
`echo "Brief description" > airflow-core/newsfragments/{PR_NUMBER}.{bugfix|feature|improvement|doc|misc}.rst`

## Boundaries

### Ask first
- Large cross-package refactors.
- New dependencies with broad impact.
- Destructive data or migration changes.

### Never
- Commit secrets, credentials, or tokens.
- Edit generated files by hand when a generation workflow exists.
- Use destructive git operations unless explicitly requested.
