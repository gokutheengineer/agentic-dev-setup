# firstmate — "talk to one agent, ship with a crew"

**What it is:** A liaison agent. Instead of juggling many agent sessions yourself, you
talk to **one** agent (the *first mate*) that dispatches and supervises a crew of worker
agents. It's the capstone of the workflow — all the other tools wired into one. Free &
OSS, and new.

## What it does for you

- Decomposes a request into **parallel tasks** (e.g. "add an update command to all 3
  CLIs" → 3 tasks).
- Spins up each in its own **tmux window** with a clean **treehouse** worktree.
- Runs a worker agent per task, then runs **no-mistakes** to validate → PR.
- Two task types: **ship** (produces PRs / local merges) and **scout** (investigation
  reports). The first mate stays read-only on your projects except safe ops + approved
  merges.
- You just keep giving it work and asking questions; it does the context-switching.

## Install

```bash
./setup.sh firstmate
```

- Clones the repo to `~/.local/share/firstmate` (kept up to date on re-run).
- Adds a **`firstmate` shell launcher** (via `~/.config/agentic-dev-setup.zsh`) that
  runs your agent harness *inside* that clone — which is how firstmate is meant to run.

## Daily use

```bash
firstmate                      # launches Claude Code inside the firstmate repo
FIRSTMATE_AGENT=codex firstmate  # or use a different harness
```

Then just talk to it:
- *"Work on lavish-axi, gh-axi, and chrome-devtools-axi — add an `update` command to
  each CLI that bumps to the latest npm version."* → it runs 3 parallel ship tasks.
- *"Look at the 3 most recent open issues in lavish-axi and tell me which are
  actionable."* → a scout task, while the ship tasks run in the background.

On **first run** it does setup and asks preferences, including the per-project delivery
mode: **full gates to PR** (uses no-mistakes), **direct-PR**, or **local-only**.

## Gotchas

- **Run it inside tmux** — each crewmate appears in its own tmux window; that's the
  intended experience.
- It depends on the rest of the stack (tmux, git, gh, treehouse, no-mistakes). On first
  launch it detects missing deps and asks consent before installing.
- Because firstmate removes so much overhead, the **bottleneck shifts to you** — knowing
  *what* to build. That's the "captain's mindset" the video ends on.
