#!/usr/bin/env bash
# Neovim — modal editor. Sourced by setup.sh.

install_nvim() {
  brew_install neovim
  # Helpers most nvim setups expect (search, file-find)
  brew_install ripgrep fd
  link "$REPO_ROOT/config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
  if have nvim; then
    ok "Neovim $(nvim --version | head -1 | awk '{print $2}') ready. Start with: nvim"
  fi
}
