-- WezTerm config — symlinked to ~/.config/wezterm/wezterm.lua
-- Docs: https://wezterm.org/config/files.html
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ── Appearance ──────────────────────────────────────────────
config.color_scheme = "Catppuccin Mocha"           -- ships with WezTerm
config.font = wezterm.font_with_fallback({ "JetBrains Mono", "Menlo" })
config.font_size = 14.0
config.line_height = 1.05
config.window_background_opacity = 0.96
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"               -- thin title bar
config.window_padding = { left = 8, right = 8, top = 6, bottom = 4 }
config.scrollback_lines = 10000

-- ── Tabs ────────────────────────────────────────────────────
-- We use tmux for multiplexing, so keep WezTerm's own tab bar minimal.
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- ── Behavior ────────────────────────────────────────────────
config.audible_bell = "Disabled"
config.adjust_window_size_when_changing_font_size = false
-- Let tmux own the prefix key; keep WezTerm keybindings out of the way.
config.enable_kitty_keyboard = true                -- better key reporting for nvim/tmux

return config
