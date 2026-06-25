# Neovim

**What it is:** A modal editor. In this agentic workflow you pop into it for quick
edits and reviews; agents do most of the heavy editing in adjacent panes.

## Install

```bash
./setup.sh nvim           # neovim + ripgrep + fd
```

Symlinks our config to `~/.config/nvim/init.lua`.

## Config — deliberately minimal

- Source of truth: [`config/nvim/init.lua`](../../config/nvim/init.lua)
- **No plugin manager.** Just great defaults so it never conflicts with a distro
  (LazyVim / kickstart.nvim) you might layer on later.
- Leader = **Space**. Truecolor on (pairs with tmux RGB passthrough). System
  clipboard, persistent undo, relative numbers, smartcase search.

### Key maps

| Keys | Action |
|------|--------|
| `<Space>w` / `<Space>q` | save / quit |
| `<Esc>` | clear search highlight |
| `Ctrl-h/j/k/l` | move between splits (matches tmux) |
| `J` / `K` (visual) | move selected lines down/up |

## Layering on a distro later

The base config is intentionally conflict-free. To go full IDE later, either:
- bootstrap `lazy.nvim` inside `init.lua`, or
- install **kickstart.nvim** / **LazyVim** into `~/.config/nvim` (back up our symlink first).

## Gotchas

- **`vim.highlight` is deprecated on nvim 0.12+** → renamed to `vim.hl`. Our config
  uses `(vim.hl or vim.highlight)` so it works on both old and new versions.
- **Colors washed out inside tmux?** Need `termguicolors` (set here) *and* tmux's
  `:RGB` override (set in our tmux.conf). Both must be present.
- Validate a config change headlessly: `nvim --headless -u init.lua +qa`.
