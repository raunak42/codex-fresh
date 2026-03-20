# codex-fresh

`codex-fresh` forks your original chat into a fresh session while maintaining the same context and establishing a fresh WebSocket connection.

It pulls the context from the same source as the original chat session saved locally on the device.
The fresh connection is established so you can continue without depending on the stale live connection from the original session that slows down responses.

If your Codex CLI session gets slow, keeps falling back from WebSocket to HTTP, or a new chat session feels fast while the original chat is not, this tool is for that case.

## AI disclaimer

This repo was generated with AI assistance. Read the code before installing it.

## Use

```bash
./install.sh
codex fresh
```

Or use the standalone command:

```bash
codex-fresh
```

If you only want the standalone command without the shell hook:

```bash
INSTALL_HOOK=0 ./install.sh
```

Useful flags:

```bash
codex-fresh --all
codex-fresh --resume
codex-fresh --include-hidden
codex-fresh --print
```

## Why not `/fork`?

- `/fork` creates a new thread inside the original running Codex session without creating a fresh connection.
- `codex fresh` starts a new local Codex process with a fresh WebSocket connection path, then forks from the selected saved local context source.
- Use `/fork` when the original connection is healthy and you only want a branch.
- Use `codex fresh` when the original session is stale, slow, or unstable.

## What it keeps

- saved conversation history
- saved working directory and git metadata
- project files on disk

## How it works

`codex-fresh` reads Codex's local thread index, shows a picker similar to `/resume`, then runs:

```bash
codex fork <session-id>
```

That means the new session starts from the same saved local context source as the selected original session at fork time.

The new process gets its own independent connection path to OpenAI. It does not borrow or reuse the original session's live connection.

Inside a git repo it scopes sessions by git root. Outside a git repo it scopes by the original working directory.

## Requirements

- Codex CLI
- Python 3 with `sqlite3`

## Compatibility

Tested against Codex layouts that use:

- `~/.codex/state_*.sqlite`
- `~/.codex/sessions/.../rollout-*.jsonl`

## License

MIT
