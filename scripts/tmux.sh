#!/usr/bin/env bash
# tmux — terminal multiplexer (persistent sessions, panes). Sourced by setup.sh.

install_tmux() {
  have tmux || brew_install tmux   # skip if provided by Nix
  # tmux 3.1+ honors XDG: ~/.config/tmux/tmux.conf
  link "$REPO_ROOT/config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
  if have tmux; then
    ok "tmux $(tmux -V | awk '{print $2}') ready. Start with: tmux"
  fi
}
