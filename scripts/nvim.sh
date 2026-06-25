#!/usr/bin/env bash
# Neovim — modal editor. Sourced by setup.sh.

install_nvim() {
  brew_install neovim
  # Helpers most nvim setups expect (search, file-find)
  brew_install ripgrep fd
  link "$REPO_ROOT/config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
  if have nvim; then
    info "Bootstrapping lazy.nvim + plugins (first run downloads them)..."
    nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1 || warn "plugin sync hiccup — open nvim and run :Lazy sync"
    ok "Neovim $(nvim --version | head -1 | awk '{print $2}') ready. Telescope: Space-f files, Space-s grep."
  fi
}
