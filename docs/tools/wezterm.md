# WezTerm

**What it is:** A fast, GPU-accelerated terminal emulator configured in Lua. It's the
window everything else (tmux, nvim, agents) runs inside.

## Install

```bash
./setup.sh wezterm        # or: brew install --cask wezterm
```

Installs the cask and symlinks our config to `~/.config/wezterm/wezterm.lua`.

## Config

- Source of truth: [`config/wezterm/wezterm.lua`](../../config/wezterm/wezterm.lua)
- Linked to: `~/.config/wezterm/wezterm.lua`
- Highlights: Catppuccin Mocha theme, JetBrains Mono 14, slight transparency+blur,
  minimal tab bar (tmux handles multiplexing), kitty keyboard protocol for better
  key reporting in nvim/tmux.

WezTerm **hot-reloads** the config on save — no restart needed.

## Daily use

| Action | Shortcut |
|--------|----------|
| New tab | `⌘T` |
| Switch tab | `⌘1`..`⌘9` |
| Split pane (native) | `⌘D` / `⌘⇧D` |
| Command palette | `⌘⇧P` |
| Font size | `⌘+` / `⌘-` / `⌘0` |
| Reload config | automatic on save |

> We mostly let **tmux** do splits/sessions (survives disconnects); WezTerm's own
> panes are there if you want them.

## Gotchas

- **Font is bundled.** JetBrains Mono ships *with* WezTerm, so the font config needs
  no separate install. `Menlo` is the system fallback.
- **Apple Silicon vs Intel brew path.** Casks land in `/Applications` either way; the
  `wezterm` CLI links into `/usr/local/bin` (Intel) or `/opt/homebrew/bin` (ARM).
- First launch on macOS may need Gatekeeper approval (right-click → Open, or
  System Settings → Privacy & Security → Open Anyway).
