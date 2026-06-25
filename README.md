# agentic-dev-setup

A reproducible **agentic development environment**: one repo that bootstraps a machine
with a terminal-centric toolchain for working with AI coding agents — terminal, editor,
agent harnesses, memory, skills, and the orchestration tools around them — plus the
configs and tips that make them work together.

It follows the **agent-engineering workflow** popularized by Kun
([kunchenguid](https://github.com/kunchenguid)), whose open-source tools (lavish,
no-mistakes, treehouse, gnhf, firstmate, AXI) this setup installs and configures.

> Goal: clone on a fresh machine, run `./setup.sh`, and have the whole toolchain ready.

## Requirements

- **macOS** (the installer uses Homebrew; Apple Silicon or Intel — arch-specific tools
  are guarded automatically).
- Xcode Command Line Tools + [Homebrew](https://brew.sh) (the script checks/installs).

## Two layers

The repo has a **declarative base** and an **imperative agentic layer** — use either or
both:

- **Nix base** ([`nix/`](nix/README.md)) — optional but recommended for a fresh Mac.
  `nix-darwin` + `home-manager` reproducibly set macOS defaults, base CLI packages,
  fonts, global git, and shell. Multi-arch: `#intel` (x86_64) and `#apple` (aarch64).
- **Agentic layer** (`setup.sh`) — the bespoke AI toolchain (agents, skills, memory,
  lavish, no-mistakes, treehouse, gnhf, firstmate, Pi) plus dotfile symlinks.

A fresh Mac runs both via [`setup/mac.sh`](setup/mac.sh): Nix base first, then the
agentic layer. Prefer pure bash? Skip Nix and just run `./setup.sh`.

## What's in here

| Path | What it is |
|------|------------|
| `setup.sh` | The agentic-layer installer. Idempotent — safe to run repeatedly. |
| `nix/` | Declarative macOS base (nix-darwin + home-manager). See [`nix/README.md`](nix/README.md). |
| `setup/mac.sh` | Fresh-Mac bootstrap: installs Nix, applies the base, runs the agentic layer. |
| `Brewfile` | Homebrew packages & casks for the bash-only path (`brew bundle`). |
| `scripts/` | Per-tool install/configure steps, sourced by `setup.sh`. |
| `config/` | Dotfiles for each tool (symlinked into place by the installer). |
| `config/skills/` | Agent skills we author — one `SKILL.md` per tool — linked into agent skill dirs by `setup.sh local-skills`. |
| `docs/` | Per-tool guides, a [tips & tricks](docs/tips-and-tricks.md) log, and [troubleshooting](docs/troubleshooting.md). |

## Quick start

```bash
# 1. Prerequisites (the installer also checks these)
xcode-select --install

# 2. Clone (fork it first if you want to version your own configs)
git clone git@github.com:gokutheengineer/agentic-dev-setup.git
cd agentic-dev-setup

# 3. Install & configure everything (idempotent)
./setup.sh

# ...or just one tool
./setup.sh wezterm
./setup.sh --list      # see all available tools
```

## The toolchain

The mental model is a **captain sailing a ship with a crew of agents**:

1. **Assemble the ship** — terminal, multiplexer, editor.
2. **Recruit & onboard the crew** — agents + memory files + skills.
3. **Work with a single crewmate** — voice input, plan with lavish, validate with no-mistakes.
4. **Work with many crewmates** — long runs (gnhf) + parallel worktrees (treehouse).
5. **Recruit a first mate** — one agent that orchestrates the whole crew.
6. **Captain's mindset** — the bottleneck becomes *what* to build, not *how*.

| Stage | Tool | What it does |
|-------|------|--------------|
| 1 Ship | [WezTerm](docs/tools/wezterm.md) | GPU terminal emulator (Lua config, rose-pine) |
| 1 Ship | [tmux](docs/tools/tmux.md) | Multiplexer — panes, windows, persistent sessions |
| 1 Ship | [Neovim](docs/tools/nvim.md) | Editor — lazy.nvim + Telescope (`Space-f` / `Space-s`) |
| 2 Crew | [Agent harnesses](docs/tools/agents.md) | Claude Code / Codex / opencode / [Pi](docs/tools/pi.md), agent-agnostic |
| 2 Crew | [Memory files](docs/tools/memory.md) | Global + project memory, `CLAUDE.md`↔`AGENTS.md` symlink |
| 2 Crew | [skills CLI](docs/tools/skills.md) | `npx skills` + skill-creator; progressive disclosure |
| 2 Crew | [OPINIONS.md](docs/tools/opinions.md) | Durable opinions fed to agents so they match your taste |
| 3 Single | [Voice input](docs/tools/voice.md) | Local dictation — OpenSuperWhisper (Apple Silicon) / VoiceInk (Intel) |
| 3 Single | [AXI](docs/tools/axi.md) | Agent-ergonomic CLI design standards |
| 3 Single | [lavish](docs/tools/lavish.md) | Interactive HTML-artifact planning |
| 3 Single | [no-mistakes](docs/tools/no-mistakes.md) | Validate first-pass code → clean PR |
| 4 Parallel | [gnhf](docs/tools/gnhf.md) | "Good night, have fun" — long-running agent loop |
| 4 Parallel | [treehouse](docs/tools/treehouse.md) | Reusable git-worktree pool |
| 5 First mate | [firstmate](docs/tools/firstmate.md) | One agent that orchestrates the crew |

See [`docs/00-overview.md`](docs/00-overview.md) for how it all fits together, and
[`docs/tips-and-tricks.md`](docs/tips-and-tricks.md) for non-obvious gotchas.

## Conventions

- **Idempotent**: every step checks "is it already installed/configured?" before acting.
- **No secrets in git**: see `.gitignore`. API keys live in `~/.config/<tool>` or a local
  `.env`, never committed.
- **Configs are symlinked**: edits in `config/` reflect live; commit them to version your
  dotfiles.
- **Cross-agent**: memory and skills are kept portable so the agent/harness is swappable.
