---
name: wezterm
description: Adjust the WezTerm terminal configuration — color scheme, font, opacity, padding, keybindings — in the user's Lua config. Use when the user asks to change how their terminal looks or behaves. Config hot-reloads on save.
---

# wezterm — Lua-configured terminal

Config (a live symlink): `agentic-dev-setup/config/wezterm/wezterm.lua` →
`~/.config/wezterm/wezterm.lua`. Edits **hot-reload on save** — no restart.

Common changes (edit the Lua):
- Theme: `config.color_scheme = "rose-pine-moon"` (any built-in scheme name).
- Font/size: `config.font` / `config.font_size` (JetBrains Mono ships bundled).
- Transparency: `config.window_background_opacity`, `config.macos_window_background_blur`.
- Keys: `config.keys = { ... }`.

Notes:
- tmux handles multiplexing here, so WezTerm's tab bar is kept minimal on purpose.
- Lua means you can use conditionals/logic, not just static values.
- On a Nix-managed Mac the WezTerm *app* comes from the Homebrew cask in the flake; this
  config symlink is owned by the bash layer either way.
