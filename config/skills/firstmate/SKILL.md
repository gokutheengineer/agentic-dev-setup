---
name: firstmate
description: Orchestrate multiple worker agents through firstmate — decompose a request into parallel ship or scout tasks, each in its own tmux window and treehouse worktree, validated by no-mistakes before a PR. Use when the user wants several tasks done in parallel, or wants to delegate coordination rather than drive each agent session by hand.
---

# firstmate — talk to one agent, ship with a crew

firstmate is a liaison agent: you give it work, it dispatches and supervises a crew of
worker agents so you stay at the captain level.

```bash
firstmate                       # launches your agent inside the firstmate clone
FIRSTMATE_AGENT=codex firstmate # use a different harness
```

Then just talk to it:
- *"Add an `update` command to lavish-axi, gh-axi, and chrome-devtools-axi."* → 3 parallel
  **ship** tasks (each → worktree → agent → no-mistakes → PR).
- *"Which of the 3 newest issues in repo X are actionable?"* → a **scout** task (report).

## Notes

- **Run it inside tmux** — each crewmate gets its own window.
- It uses **treehouse** for isolated worktrees and **no-mistakes** to validate → PR; first
  run asks the per-project delivery mode (full-gates-to-PR / direct-PR / local-only).
- It stays read-only on your projects except safe ops + approved merges.
- Best for fan-out work; for a single focused task, just use one agent directly.
