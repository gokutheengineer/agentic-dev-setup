# agentic-dev-setup — single shell entrypoint.
# Linked to ~/.config/agentic-dev-setup.zsh and sourced from ~/.zshrc by setup.sh.
# All aliases / PATH / env for the agentic toolchain live here.

# --- PATH: user-local bins (no-mistakes, treehouse install here) ---
export PATH="$HOME/.local/bin:$PATH"

# --- skills CLI: always-latest, no global install ---
alias skills='npx -y skills@latest'

# --- firstmate: run your agent harness from inside the firstmate clone ---
# Override the agent with FIRSTMATE_AGENT (claude | codex | opencode | pi).
firstmate() {
  local dir="$HOME/.local/share/firstmate"
  if [ ! -d "$dir" ]; then
    echo "firstmate not installed. Run: ./setup.sh firstmate" >&2; return 1
  fi
  ( cd "$dir" && "${FIRSTMATE_AGENT:-claude}" "$@" )
}

# (more tool aliases/PATH appended as we add tools)
