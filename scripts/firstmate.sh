#!/usr/bin/env bash
# firstmate — talk to ONE agent (the "first mate") that supervises a crew of worker
# agents: it decomposes your request into parallel tasks, spins up tmux windows, calls
# treehouse for isolated worktrees, runs agents, then runs no-mistakes to validate and
# raise PRs. You stay at the captain level. Free & OSS, and new.
#
# It's used by cloning the repo and running your agent harness FROM that directory.
# We clone to a stable path and add a `firstmate` launcher (see config/shell/agentic.zsh).

FIRSTMATE_DIR="$HOME/.local/share/firstmate"

install_firstmate() {
  mkdir -p "$(dirname "$FIRSTMATE_DIR")"
  if [ -d "$FIRSTMATE_DIR/.git" ]; then
    info "Updating firstmate clone..."
    git -C "$FIRSTMATE_DIR" pull --ff-only 2>&1 | tail -2 || warn "pull skipped"
  else
    info "Cloning firstmate to $FIRSTMATE_DIR ..."
    git clone --depth 1 https://github.com/kunchenguid/firstmate "$FIRSTMATE_DIR" 2>&1 | tail -2
  fi
  ensure_shell_sourced   # makes the `firstmate` launcher available
  ok "firstmate cloned. Launch with:  firstmate   (runs your agent inside the repo)"
  info "First run does setup + asks preferences. It works best inside tmux."
  info "Recommended: run it inside a tmux session so each crewmate gets its own window."
}
