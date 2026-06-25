---
name: nvim
description: The user's Neovim setup and keymaps (lazy.nvim + Telescope; leader = Space). Use when editing the user's nvim config or guiding them through nvim actions, so suggestions match their actual keybindings and plugins.
---

# nvim — the user's config & keymaps

Config (live symlink): `agentic-dev-setup/config/nvim/init.lua` → `~/.config/nvim/init.lua`.
Plugin manager: **lazy.nvim**. Theme: rose-pine (moon).

## Keymaps (leader = `Space`)

| Keys | Action |
|------|--------|
| `Space f` | find files (Telescope) |
| `Space s` | live grep the project (Telescope) |
| `Space b` | open buffers |
| `Space w` / `Space q` | save / quit |
| `Ctrl-h/j/k/l` | move between splits (matches tmux) |
| `J` / `K` (visual) | move selected lines down/up |
| `11k`, `5j` | jump N lines (relative numbers are on) |

## Editing the config

- Add plugins inside the `require("lazy").setup({ ... })` block.
- **Treesitter is pinned to `branch = "master"`** (the `main` branch dropped the
  `.configs` API). Add parsers with `:TSInstall <lang>`.
- Validate headlessly after edits: `nvim --headless "+Lazy! sync" +qa`.
- Quitting vim: `:q` (`:q!` discard, `:wq` save+quit).
