#!/usr/bin/env bash
# treehouse — a pool of reusable git worktrees. `treehouse` drops you into a fresh
# worktree subshell; close the tab and it's returned to the pool for reuse. Removes
# the overhead of naming/tracking/cleaning manual `git worktree` dirs. Free & OSS.
#
# Installer reviewed in docs/tools/treehouse.md.

install_treehouse() {
  mkdir -p "$HOME/.local/bin"
  if have treehouse || [ -x "$HOME/.local/bin/treehouse" ]; then
    ok "treehouse already installed. Re-run installer manually to update."
  else
    info "Installing treehouse (downloads release binary from GitHub)..."
    # Put ~/.local/bin on PATH for the install so it lands there (no sudo).
    curl -fsSL https://kunchenguid.github.io/treehouse/install.sh \
      | PATH="$HOME/.local/bin:$PATH" sh
  fi
  if [ -x "$HOME/.local/bin/treehouse" ]; then
    ok "treehouse ready. In a repo: 'treehouse' for a worktree, 'treehouse status' to list."
  fi
}
