#!/usr/bin/env bash
#
# agentic-dev-setup bootstrapper.
#
#   ./setup.sh              install / configure everything (idempotent)
#   ./setup.sh wezterm tmux only those tools
#   ./setup.sh --list       show available tools
#
# Safe to re-run. Each tool's logic lives in scripts/<tool>.sh.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export REPO_ROOT
# shellcheck source=scripts/lib.sh
source "$REPO_ROOT/scripts/lib.sh"

# Install order matters (deps first). skills before axi/lavish (gateway).
TOOLS=(wezterm tmux nvim skills opensuperwhisper axi lavish no-mistakes treehouse gnhf firstmate)

usage() { sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'; }

ensure_homebrew() {
  step "Homebrew"
  if have brew; then ok "Homebrew present ($(brew --version | head -1))"; return; fi
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Apple Silicon path
  [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
}

run_tool() {
  local t="$1" script="$REPO_ROOT/scripts/${1}.sh"
  local fn="install_${t//-/_}"   # hyphens aren't legal in bash fn names
  if [ ! -f "$script" ]; then warn "no installer for '$t' yet (scripts/${t}.sh missing) — skipping"; return; fi
  step "$t"
  # shellcheck disable=SC1090
  source "$script"
  "$fn"
}

main() {
  case "${1:-}" in
    -h|--help) usage; exit 0 ;;
    --list)    printf '%s\n' "${TOOLS[@]}"; exit 0 ;;
  esac

  ensure_homebrew

  if [ "$#" -eq 0 ]; then
    info "Installing all tools: ${TOOLS[*]}"
    for t in "${TOOLS[@]}"; do run_tool "$t"; done
  else
    for t in "$@"; do run_tool "$t"; done
  fi

  step "Done"
  ok "Setup complete. Open a new terminal to pick up shell changes."
}

main "$@"
