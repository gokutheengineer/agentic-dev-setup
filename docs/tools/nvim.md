# Neovim

**What it is:** A modal editor (modern vim). In Kun's workflow it keeps your hands on
the keyboard; you pop in for quick edits/reviews while agents do the heavy editing.

## Install

```bash
./setup.sh nvim           # neovim + ripgrep + fd, then bootstraps plugins
```

Symlinks our config to `~/.config/nvim/init.lua` and runs `:Lazy sync` once.

## Config — replicates the video's capabilities

- Source of truth: [`config/nvim/init.lua`](../../config/nvim/init.lua)
- **Plugin manager:** [lazy.nvim](https://github.com/folke/lazy.nvim) (auto-bootstraps).
- **Theme:** rose-pine (moon) — matches the WezTerm scheme.
- **Telescope** for the `Space-f` / `Space-s` fuzzy workflow Kun shows.
- Relative line numbers (the "`11k` to jump 11 lines up" trick), system clipboard,
  persistent undo, smartcase search.

### Key maps

| Keys | Action |
|------|--------|
| `Space f` | **Find files** by name (Telescope) |
| `Space s` | **Search / live grep** the project (Telescope) |
| `Space b` | Open buffers |
| `Space w` / `Space q` | save / quit |
| `Esc` | clear search highlight |
| `Ctrl-h/j/k/l` | move between splits (matches tmux) |
| `J` / `K` (visual) | move selected lines down/up |
| `11k` / `5j` | jump N lines using relative numbers |

> **Quitting vim:** `:q` (or `Space q`). `:q!` to discard changes. `:wq` to save+quit.

## Gotchas

- **Treesitter is pinned to `master`.** Its new `main` branch dropped the
  `nvim-treesitter.configs` API our config uses — pinning avoids a load error.
  Add parsers on demand: `:TSInstall lua python …`.
- **`vim.highlight` → `vim.hl`** on nvim 0.12+; config uses `(vim.hl or vim.highlight)`.
- **Colors washed out inside tmux?** Need `termguicolors` (set) + tmux `:RGB` override
  (set in our tmux.conf).
- Validate headlessly after edits: `nvim --headless "+Lazy! sync" +qa`.
