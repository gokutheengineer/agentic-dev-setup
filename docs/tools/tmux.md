# tmux

**What it is:** A terminal multiplexer. It runs *inside* WezTerm and gives you
persistent sessions (detach/reattach — your agents keep running after you close the
window) plus windows and panes.

## Install

```bash
./setup.sh tmux           # or: brew install tmux
```

Symlinks our config to `~/.config/tmux/tmux.conf` (XDG path, tmux 3.1+).

## Config

- Source of truth: [`config/tmux/tmux.conf`](../../config/tmux/tmux.conf)
- Prefix remapped to **`C-a`** (instead of `C-b`).
- Truecolor passthrough so nvim themes render correctly.
- Mouse on, 50k scrollback, vi keys, splits keep current path.

## Daily use

> Prefix = **`Ctrl-a`**, then the key below.

| Action | Keys |
|--------|------|
| New session (named) | `tmux new -s work` |
| Detach (leave it running) | `prefix d` |
| List / attach | `tmux ls` · `tmux attach -t work` |
| Split vertical / horizontal | `prefix \|` · `prefix -` |
| Move between panes | `prefix h/j/k/l` |
| Resize pane | `prefix H/J/K/L` (repeatable) |
| New window | `prefix c` |
| Next/prev window | `prefix n` / `prefix p` |
| Reload config | `prefix r` |
| Scroll/copy mode | `prefix [` (vi keys, `q` to exit) |

### The agentic-dev win: persistence

Start a long agent run, `prefix d` to detach, close your laptop, come back, and
`tmux attach` — it's still there. This is why we run agents inside tmux.

## Gotchas

- **`C-a` collides with shell "go to line start."** Press `C-a C-a` to send a literal
  `Ctrl-a` to the shell. (Or change the prefix back to `C-b` in the config.)
- **Colors look washed out in nvim?** That's a truecolor passthrough issue — handled
  here by `terminal-overrides ...:RGB`. Verify nvim has `set termguicolors`.
- **Esc feels laggy in nvim:** fixed via `escape-time 10`.
