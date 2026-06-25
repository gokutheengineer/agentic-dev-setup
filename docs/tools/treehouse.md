# treehouse — reusable git worktree pool

**What it is:** A manager for a pool of isolated, **reusable** git worktrees. Run
`treehouse` and it drops you into a fresh worktree subshell; close the tab and it's
returned to the pool. This removes the overhead of plain `git worktree` (naming dirs,
remembering what's where, manual cleanup). Free & open source.

## Why (the parallel-agents problem)

To run multiple agents at once without them stepping on each other, each needs its own
worktree. Manual worktrees become **mental debt**: *"what was I doing in `hibit-2`? is
an agent still running there?"* treehouse makes worktrees disposable and self-managing.

## Install

```bash
./setup.sh treehouse
```

Reviewed installer (`kunchenguid.github.io/treehouse/install.sh`): downloads the release
binary into `~/.local/bin` (our PATH, no sudo). No daemon.

## Daily use

```bash
cd <your repo>
treehouse              # acquire a fresh worktree + drop into a subshell
# ...run an agent / do work here...
exit                   # close the subshell -> worktree returns to the pool

treehouse              # again -> reuses an idle worktree if available, else creates one
treehouse status       # list all worktrees and which are in use vs idle
```

Pattern from the video: open a tmux tab → `treehouse` → launch an agent → repeat in new
tabs for parallel sessions. Each agent is isolated; none conflict.

## Gotchas

- Worktrees are **reused**, keeping deps/build cache warm — faster than re-cloning.
- It knows you're done when the **subshell exits** (i.e. you close the tab), so let it
  manage cleanup instead of `git worktree remove`.
- Pairs naturally with **gnhf** (long runs) and **firstmate** (which calls treehouse
  under the hood).
