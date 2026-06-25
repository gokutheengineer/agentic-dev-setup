-- Neovim config — symlinked to ~/.config/nvim/init.lua
-- Replicates the capabilities shown in Kun's video: relative numbers,
-- Space-f (find files) and Space-s (live grep) via Telescope, rose-pine theme.

-- ── Leader (must be set before plugins/keymaps) ──────────────
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ── Core options ─────────────────────────────────────────────
local o = vim.opt
o.number = true
o.relativenumber = true      -- relative numbers (the "11k to jump" trick from the video)
o.mouse = "a"
o.clipboard = "unnamedplus"  -- system clipboard
o.termguicolors = true       -- truecolor (pairs with tmux RGB override)
o.ignorecase = true
o.smartcase = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.wrap = false
o.scrolloff = 8
o.signcolumn = "yes"
o.undofile = true
o.splitright = true
o.splitbelow = true
o.updatetime = 250
o.timeoutlen = 400

-- ── Non-plugin keymaps ───────────────────────────────────────
local map = vim.keymap.set
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<C-h>", "<C-w>h"); map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k"); map("n", "<C-l>", "<C-w>l")
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Briefly highlight yanked text",
  callback = function() (vim.hl or vim.highlight).on_yank() end,
})

-- ── Bootstrap lazy.nvim (plugin manager) ─────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ── Plugins ──────────────────────────────────────────────────
require("lazy").setup({
  -- Theme (matches the WezTerm rose-pine scheme)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      require("rose-pine").setup({ variant = "moon" })
      vim.cmd.colorscheme("rose-pine-moon")
    end,
  },

  -- Fuzzy finder: the Space-f / Space-s workflow from the video
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      map("n", "<leader>f", builtin.find_files, { desc = "Find files" })
      map("n", "<leader>s", builtin.live_grep,  { desc = "Search (grep) in project" })
      map("n", "<leader>b", builtin.buffers,    { desc = "Open buffers" })
      map("n", "<leader>h", builtin.help_tags,  { desc = "Help tags" })
    end,
  },

  -- Treesitter syntax. Parsers are compiled on demand (needs a C compiler);
  -- none are forced at install time so first sync stays fast.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",          -- classic API; the new `main` branch dropped .configs
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {},      -- add languages as you need them: :TSInstall lua
        auto_install = false,
        highlight = { enable = true },
      })
    end,
  },
}, {
  -- lazy.nvim options
  install = { colorscheme = { "rose-pine-moon" } },
  checker = { enabled = false },
})
