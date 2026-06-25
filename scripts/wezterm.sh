#!/usr/bin/env bash
# WezTerm — GPU terminal emulator. Sourced by setup.sh.

install_wezterm() {
  cask_install wezterm
  # Modern WezTerm reads ~/.config/wezterm/wezterm.lua
  link "$REPO_ROOT/config/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
  if have_app "WezTerm"; then
    ok "WezTerm installed. Launch it and your config is already linked."
  else
    warn "WezTerm.app not found in /Applications — check the cask install output."
  fi
}
