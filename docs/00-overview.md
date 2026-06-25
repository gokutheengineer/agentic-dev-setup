# Overview — how this setup fits together

The mental model for the agentic dev environment, layer by layer:

```
┌─────────────────────────────────────────────┐
│ WezTerm            GPU terminal — the window  │
│  └─ tmux           persistent sessions/panes  │
│      └─ Neovim     the editor                 │
│      └─ Claude Code / agentic CLIs            │
│                                               │
│ Voice:  OpenSuperWhisper → dictate prompts    │
│ Agent tooling: skills, AXI, kunchenguid suite │
└─────────────────────────────────────────────┘
```

- **WezTerm** is the terminal you launch. Fast, scriptable in Lua.
- **tmux** runs inside it so sessions survive disconnects and you get panes/windows.
- **Neovim** is the editor; agentic CLIs run in adjacent panes.
- **OpenSuperWhisper** lets you dictate prompts instead of typing them.
- **skills / AXI / kunchenguid tools** extend the agents themselves.

## How to use this repo

- New machine? → `README.md` → run `./setup.sh`.
- Setting up one tool? → its page in `docs/tools/`.
- Hit a wall? → `docs/troubleshooting.md`.
- Learned something? → add it to `docs/tips-and-tricks.md`.

## Per-tool doc template

Each `docs/tools/<tool>.md` follows:
1. **What it is** — one line.
2. **Install** — exact commands (also encoded in `scripts/<tool>.sh`).
3. **Config** — what lives in `config/<tool>/` and where it links.
4. **Daily use** — the handful of commands/keys you actually need.
5. **Gotchas** — anything that bit us.
