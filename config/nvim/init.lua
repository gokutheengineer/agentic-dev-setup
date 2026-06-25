-- Neovim config — symlinked to ~/.config/nvim/init.lua
-- Intentionally minimal & self-contained: great defaults, NO plugin manager,
-- so it never fights a distro (LazyVim/kickstart) you might layer on later.

-- ── Leader (set before plugins/keymaps) ──────────────────────
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ── Core options ─────────────────────────────────────────────
local o = vim.opt
o.number = true              -- absolute line numbers
o.relativenumber = true      -- + relative (fast j/k motions)
o.mouse = "a"                -- mouse in all modes
o.clipboard = "unnamedplus"  -- yank to system clipboard
o.termguicolors = true       -- truecolor (pairs with tmux RGB override)
o.ignorecase = true
o.smartcase = true           -- case-sensitive only if you type a capital
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.wrap = false
o.scrolloff = 8              -- keep 8 lines of context around cursor
o.signcolumn = "yes"
o.undofile = true            -- persistent undo across sessions
o.splitright = true
o.splitbelow = true
o.updatetime = 250
o.timeoutlen = 400

-- ── Keymaps ──────────────────────────────────────────────────
local map = vim.keymap.set
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
-- window navigation matches tmux (h/j/k/l)
map("n", "<C-h>", "<C-w>h"); map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k"); map("n", "<C-l>", "<C-w>l")
-- move selected lines up/down
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- ── Quality-of-life autocmds ─────────────────────────────────
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Briefly highlight yanked text",
  callback = function() (vim.hl or vim.highlight).on_yank() end,
})

-- To add plugins later, bootstrap lazy.nvim here. Kept out on purpose so the
-- base config stays conflict-free with any distro you might install.
