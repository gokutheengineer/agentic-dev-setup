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

This setup follows an agentic-dev YouTube tutorial. Tools, in install order:

| Tool | Purpose | Status |
|------|---------|--------|
| [WezTerm](docs/tools/wezterm.md) | GPU terminal emulator | ✅ |
| [tmux](docs/tools/tmux.md) | Terminal multiplexer (persistent sessions) | ✅ |
| [Neovim](docs/tools/nvim.md) | Modal editor | ⏳ |
| [skills CLI](docs/tools/skills.md) | `npx skills` — Vercel Labs agent skills | ⏳ |
| [OpenSuperWhisper](docs/tools/opensuperwhisper.md) | Local voice dictation | ⏳ |
| [AXI](docs/tools/axi.md) | agentic tool (axi.md) | ⏳ |
| [lavish](docs/tools/kunchenguid-suite.md) | kunchenguid suite | ⏳ |
| [no-mistakes](docs/tools/kunchenguid-suite.md) | kunchenguid suite | ⏳ |
| [gnhf](docs/tools/kunchenguid-suite.md) | kunchenguid suite | ⏳ |
| [treehouse](docs/tools/kunchenguid-suite.md) | kunchenguid suite | ⏳ |
| [firstmate](docs/tools/kunchenguid-suite.md) | kunchenguid suite | ⏳ |

Status legend: ⏳ planned · 🔧 in progress · ✅ done

## Conventions

- **Idempotent**: every step checks "is it already installed/configured?" before acting. Safe to re-run.
- **No secrets in git**: see `.gitignore`. API keys live in `~/.config/<tool>` or a local `.env`, never committed.
- **Configs are symlinked**: edits in `config/` reflect live; commit them to version your dotfiles.
