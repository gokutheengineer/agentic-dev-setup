# agentic-dev-setup

My reproducible **agentic development environment** — one repo to bootstrap a new
laptop (or recover the current one) with every terminal, editor, and AI tool I use,
plus the configs and the hard-won tips that make them work together.

> Goal: clone this repo on a fresh machine, run `./setup.sh`, and be productive in minutes.

## What's in here

| Path | What it is |
|------|------------|
| `setup.sh` | The one command. Idempotent installer — run it as many times as you like. |
| `Brewfile` | All Homebrew packages & casks in one place (`brew bundle`). |
| `scripts/` | Per-tool install/configure steps, sourced by `setup.sh`. |
| `config/` | Dotfiles for each tool (symlinked into place by the installer). |
| `docs/` | Per-tool guides, a running [tips & tricks](docs/tips-and-tricks.md) log, and [troubleshooting](docs/troubleshooting.md). |

## Quick start (fresh machine)

```bash
# 1. Prerequisites: Xcode CLT + Homebrew (setup.sh will check/install)
xcode-select --install

# 2. Clone
git clone git@github.com:gokutheengineer/agentic-dev-setup.git
cd agentic-dev-setup

# 3. Bootstrap everything
./setup.sh

# ...or install a single tool
./setup.sh wezterm
```

## The toolchain

Replicates **Kun's (kunchenguid) agent-engineering workflow** ([video transcript](videoscript.txt)).
The mental model is a **captain sailing a ship with a crew of agents**:

1. **Assemble the ship** — terminal, multiplexer, editor.
2. **Recruit & onboard the crew** — agents + memory files + skills.
3. **Work with a single crewmate** — voice input, plan with lavish, validate with no-mistakes.
4. **Work with many crewmates** — long runs (gnhf) + parallel worktrees (treehouse).
5. **Recruit a first mate** — one agent that orchestrates the whole crew.
6. **Captain's mindset** — your bottleneck becomes *what* to build, not *how*.

| Stage | Tool | Purpose | Status |
|-------|------|---------|--------|
| 1 Ship | [WezTerm](docs/tools/wezterm.md) | GPU terminal emulator (Lua config, rose-pine) | ✅ |
| 1 Ship | [tmux](docs/tools/tmux.md) | Multiplexer — panes, windows, persistent sessions | ✅ |
| 1 Ship | [Neovim](docs/tools/nvim.md) | Editor — lazy.nvim + Telescope (`Space-f`/`Space-s`) | ✅ |
| 2 Crew | [Agent harnesses](docs/tools/agents.md) | Claude Code / Codex / opencode / Pi (agent-agnostic) | ✅ |
| 2 Crew | [Memory files](docs/tools/memory.md) | Global + project memory, `CLAUDE.md`↔`AGENTS.md` symlink | ✅ |
| 2 Crew | [skills CLI](docs/tools/skills.md) | `npx skills` + skill-creator; progressive disclosure | ✅ |
| 3 Single | [OpenSuperWhisper](docs/tools/opensuperwhisper.md) | Local voice dictation | ✅ scripted (arm64 only) |
| 3 Single | [AXI](docs/tools/axi.md) | Agent-ergonomic CLI design standards | ✅ |
| 3 Single | [lavish](docs/tools/lavish.md) | Interactive HTML-artifact planning | ✅ |
| 3 Single | [no-mistakes](docs/tools/no-mistakes.md) | Validate first-pass code → clean PR | ✅ |
| 4 Parallel | [gnhf](docs/tools/gnhf.md) | "Good night, have fun" — long-running agent loop | ✅ |
| 4 Parallel | [treehouse](docs/tools/treehouse.md) | Reusable git-worktree pool | ✅ |
| 5 First mate | [firstmate](docs/tools/firstmate.md) | One agent that orchestrates the crew | ✅ |

Status legend: ⏳ planned · 🔧 in progress · ✅ done

See [`docs/00-overview.md`](docs/00-overview.md) for how it all fits together, and
[`docs/tips-and-tricks.md`](docs/tips-and-tricks.md) for the gotchas we hit.

## Conventions

- **Idempotent**: every step checks "is it already installed/configured?" before acting. Safe to re-run.
- **No secrets in git**: see `.gitignore`. API keys live in `~/.config/<tool>` or a local `.env`, never committed.
- **Configs are symlinked**: edits in `config/` reflect live; commit them to version your dotfiles.
