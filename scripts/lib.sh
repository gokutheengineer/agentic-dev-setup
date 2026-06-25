#!/usr/bin/env bash
# Shared helpers for setup scripts. Source this; don't run it.

# ---- pretty logging ---------------------------------------------------------
if [ -t 1 ]; then
  _C_RESET=$'\033[0m'; _C_BLUE=$'\033[34m'; _C_GREEN=$'\033[32m'
  _C_YELLOW=$'\033[33m'; _C_RED=$'\033[31m'; _C_BOLD=$'\033[1m'
else
  _C_RESET=; _C_BLUE=; _C_GREEN=; _C_YELLOW=; _C_RED=; _C_BOLD=
fi
info()  { printf '%s\n' "${_C_BLUE}==>${_C_RESET} $*"; }
ok()    { printf '%s\n' "${_C_GREEN}✓${_C_RESET} $*"; }
warn()  { printf '%s\n' "${_C_YELLOW}!${_C_RESET} $*" >&2; }
err()   { printf '%s\n' "${_C_RED}✗${_C_RESET} $*" >&2; }
step()  { printf '\n%s\n' "${_C_BOLD}── $* ──${_C_RESET}"; }

# ---- predicates -------------------------------------------------------------
have()        { command -v "$1" >/dev/null 2>&1; }
have_cask()   { brew list --cask "$1" >/dev/null 2>&1; }
have_app()    { [ -d "/Applications/$1.app" ] || [ -d "$HOME/Applications/$1.app" ]; }

# ---- actions (idempotent) ---------------------------------------------------
# brew_install <formula...>  — install only what's missing
brew_install() {
  for f in "$@"; do
    if brew list --formula "$f" >/dev/null 2>&1; then
      ok "$f already installed"
    else
      info "brew install $f"; brew install "$f"
    fi
  done
}

# cask_install <cask...>
cask_install() {
  for c in "$@"; do
    if have_cask "$c"; then
      ok "$c (cask) already installed"
    else
      info "brew install --cask $c"; brew install --cask "$c"
    fi
  done
}

# link <src-in-repo> <dest>  — backup existing, then symlink
link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    ok "linked: $dest"
    return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    local bak="${dest}.backup.$(date +%Y%m%d%H%M%S)"
    warn "backing up existing $dest -> $bak"
    mv "$dest" "$bak"
  fi
  ln -s "$src" "$dest"
  ok "linked: $dest -> $src"
}

# ensure_line <line> <file>  — append line only if not already present
ensure_line() {
  local line="$1" file="$2"
  mkdir -p "$(dirname "$file")"
  touch "$file"
  if grep -qsF -- "$line" "$file"; then
    ok "already in $(basename "$file"): ${line:0:48}…"
  else
    printf '\n%s\n' "$line" >> "$file"
    ok "added to $(basename "$file"): ${line:0:48}…"
  fi
}

# ensure_shell_sourced — make ~/.zshrc source our single agentic shell entrypoint
ensure_shell_sourced() {
  link "$REPO_ROOT/config/shell/agentic.zsh" "$HOME/.config/agentic-dev-setup.zsh"
  # On a Nix machine, home-manager owns ~/.zshrc (a read-only symlink into /nix/store)
  # and sources our entrypoint via programs.zsh.initExtra — don't append to it.
  if [ -L "$HOME/.zshrc" ] && readlink "$HOME/.zshrc" | grep -q '/nix/store/'; then
    ok ".zshrc is home-manager managed; entrypoint sourced via Nix (skipping append)"
    return
  fi
  ensure_line '[ -f ~/.config/agentic-dev-setup.zsh ] && source ~/.config/agentic-dev-setup.zsh' "$HOME/.zshrc"
}

# REPO_ROOT is exported by setup.sh
: "${REPO_ROOT:?lib.sh must be sourced from setup.sh}"
