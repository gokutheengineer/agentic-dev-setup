---
name: treehouse
description: Use treehouse to get an isolated, reusable git worktree (dropped into a clean subshell) for a task, so parallel work or risky changes never collide with the main checkout. Use when starting parallel agent sessions on the same repo, when the user asks for an isolated worktree, or before an autonomous loop that shouldn't touch the main tree.
---

# treehouse — disposable, reusable git worktrees

Removes the overhead of manual `git worktree` (naming, tracking, cleanup).

```bash
cd <repo>
treehouse              # acquire a fresh worktree + drop into a subshell
# ...do isolated work / run an agent here...
exit                   # closing the subshell returns the worktree to the pool
treehouse status       # list worktrees: in-use vs idle
```

- Re-running `treehouse` **reuses an idle worktree** (deps/build cache stay warm) or
  creates a new one.
- It knows you're done when the **subshell exits** — let it manage cleanup; don't
  `git worktree remove` by hand.

## When to use it

- Running multiple agents on one repo at once (each gets its own worktree → no conflicts).
- Trying something risky without dirtying the main checkout.
- Pairs with **tmux** (one worktree per window) and **gnhf** (isolate an overnight loop
  with `--worktree`). **firstmate** calls treehouse under the hood.
