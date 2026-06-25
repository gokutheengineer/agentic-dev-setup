---
name: tmux
description: Use tmux to run long-lived or background commands in detachable sessions with split panes, so work survives disconnects and several things run side by side. Use when starting a long build/test/agent run the user may leave running, when reattaching to earlier work, or when the user mentions tmux, sessions, panes, or windows.
---

# tmux — persistent sessions for long/parallel work

Prefix is **`Ctrl-a`** (this setup remaps it from `C-b`).

## Run something that must survive disconnects

```bash
tmux new -s work          # start a named session
# ...launch the long task / agent here...
# detach (leave it running):  Ctrl-a d
tmux ls                   # list sessions
tmux attach -t work       # reattach later (even from another device)
```

This is the core win: start an agent/build, detach, close the laptop, reattach later —
it's still running.

## Panes & windows (inside a session)

| Action | Keys |
|--------|------|
| Split vertical / horizontal | `Ctrl-a \|` · `Ctrl-a -` |
| Move between panes | `Ctrl-a h/j/k/l` |
| New window (tab) | `Ctrl-a c` · switch: `Ctrl-a n/p` |
| Scroll/copy mode | `Ctrl-a [` (vi keys, `q` to exit) |
| Reload config | `Ctrl-a r` |

## Notes

- To send a literal `Ctrl-a` to the shell (start-of-line), press it twice.
- Config: `agentic-dev-setup/config/tmux/tmux.conf`.
- For *parallel* work in separate worktrees, pair with the **treehouse** skill.
