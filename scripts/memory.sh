#!/usr/bin/env bash
# Memory files — global agent memory shared across Claude Code and Codex/others.
# The repo file is the single source of truth (version-controlled); both agents'
# global memory paths symlink to it. This is the "CLAUDE.md <-> AGENTS.md" trick
# from the video, with the added benefit that the content lives in git.

install_memory() {
  local src="$REPO_ROOT/config/memory/global.md"

  # Claude Code global memory
  link "$src" "$HOME/.claude/CLAUDE.md"

  # Codex global memory (only if codex is set up)
  if [ -d "$HOME/.codex" ] || have codex; then
    link "$src" "$HOME/.codex/AGENTS.md"
  fi

  # opencode global memory (if present)
  if [ -d "$HOME/.config/opencode" ] || have opencode; then
    link "$src" "$HOME/.config/opencode/AGENTS.md"
  fi

  ok "Global memory linked. Edit it in: config/memory/global.md (one file, all agents)."
  info "For a new project, copy config/memory/project-template.md to the repo root as"
  info "CLAUDE.md and 'ln -s CLAUDE.md AGENTS.md' so both agents share it."
}
