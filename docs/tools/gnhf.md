# gnhf — "good night, have fun" (long-running tasks)

**What it is:** An orchestrator that runs a coding agent in a **loop** toward an
objective, committing successful changes and rolling back failures, until a stop
condition is met. Built for long runs — including literally overnight. Free & OSS.

## Why

To do more in parallel, you want agents working *longer* in the middle of a task while
you do other things. gnhf keeps an agent productive for hours: *"keep going until
there's no more problem to find."* Best for **verifiable / judgment-trustable**
objectives — reduce page-load time, raise e2e coverage, hunt usability bugs, run
hypothesis-improvement loops.

## Install

```bash
./setup.sh gnhf            # npm install -g gnhf
```

⚠️ **Node ≥20 required** (you're currently on 18). It runs on 18 in practice, but if it
misbehaves, get a modern node *without* disturbing your other projects:

```bash
brew install fnm           # fast node version manager
fnm install 20 && fnm use 20
```

## Daily use

```bash
gnhf "Pretend you are a 7-year-old using the app end to end. Find the first usability
problem that confuses a kid; if you find one, fix it, then repeat."

# common caps / options:
gnhf "<objective>" --max-iterations 50
gnhf "<objective>" --max-tokens 2000000
gnhf "<objective>" --stop-when "no more issues"
gnhf "<objective>" --worktree            # isolate so other agents can run too
gnhf "<objective>" --agent codex         # claude | codex | opencode | copilot | pi | ...
gnhf "<objective>" --prevent-sleep on    # keep the machine awake overnight
```

While running it shows iterations (as moons), token usage, and commit count. When you
wake up: review the list of commits on the new branch and keep what you want.

## vs `/goal` in Claude Code / Codex

gnhf gives finer control — explicit **token cap / iteration cap / stop condition** — so
you don't wake up to a blown weekly quota.

## Gotchas

- Point it at **verifiable** goals or ones where you trust the agent's judgment; it's
  not for vague open-ended product design.
- Use `--worktree` (or run via [treehouse](treehouse.md)) so an overnight loop doesn't
  block other parallel work in the same repo.
