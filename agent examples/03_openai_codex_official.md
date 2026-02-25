# AGENTS.md – OpenAI Codex Official

Source: [openai/codex/AGENTS.md](https://github.com/openai/codex/blob/main/AGENTS.md)

```md
# Rust/codex-rs

In the codex-rs folder where the rust code lives:

- Crate names are prefixed with `codex-`. For example, the `core` folder's crate is named `codex-core`
- When using format! and you can inline variables into {}, always do that.
- Install any commands the repo relies on (for example `just`, `rg`, or `cargo-insta`) if they aren't already available before running instructions here.
- Never add or modify any code related to `CODEX_SANDBOX_NETWORK_DISABLED_ENV_VAR` or `CODEX_SANDBOX_ENV_VAR`.
  - You operate in a sandbox where `CODEX_SANDBOX_NETWORK_DISABLED=1` will be set whenever you use the `shell` tool.
  - When spawning processes using Seatbelt, `CODEX_SANDBOX=seatbelt` will be set on the child process.
- Always collapse if statements per https://rust-lang.github.io/rust-clippy/master/index.html#collapsible_if
- Always inline format! args when possible per https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
- Use method references over closures when possible per https://rust-lang.github.io/rust-clippy/master/index.html#redundant_closure_for_method_calls
- When possible, make `match` statements exhaustive and avoid wildcard arms.
- When writing tests, prefer comparing the equality of entire objects over fields one by one.
- When making a change that adds or changes an API, ensure that the documentation in the `docs/` folder is up to date if applicable.
- If you change `ConfigToml` or nested config types, run `just write-config-schema` to update `codex-rs/core/config.schema.json`.
- If you change Rust dependencies, run `just bazel-lock-update` to refresh `MODULE.bazel.lock`.
- Do not create small helper methods that are referenced only once.

Run `just fmt` automatically after you have finished making Rust code changes.

## Tests

### Snapshot tests
This repo uses snapshot tests (via `insta`), especially in `codex-rs/tui`.

When UI or text output changes intentionally, update the snapshots:
- Run tests to generate any updated snapshots: `cargo test -p codex-tui`
- Check what's pending: `cargo insta pending-snapshots -p codex-tui`
- Accept all new snapshots: `cargo insta accept -p codex-tui`

### Test assertions
- Tests should use pretty_assertions::assert_eq for clearer diffs.
- Prefer deep equals comparisons whenever possible.
- Avoid mutating process environment in tests; prefer passing environment-derived flags or dependencies from above.
```

## App-server API Development Best Practices

- All active API development should happen in app-server v2. Do not add new API surface area to v1.
- Follow payload naming consistently: `*Params` for requests, `*Response` for responses, `*Notification` for notifications.
- Expose RPC methods as `<resource>/<method>` and keep `<resource>` singular.
- Always expose fields as camelCase on the wire with `#[serde(rename_all = "camelCase")]`.
- For new list methods, implement cursor pagination by default.
- Use `#[ts(export_to = "v2/")]` on v2 request/response/notification types.

## Development Workflow
- Update docs/examples when API behavior changes.
- Regenerate schema fixtures when API shapes change: `just write-app-server-schema`
- Validate with `cargo test -p codex-app-server-protocol`.
