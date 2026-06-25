#!/usr/bin/env bash
# opinions — installs the OPINIONS.md skill (the user's software taste, mirroring Kun)
# so agents apply it on judgment calls. The core-stances summary lives always-on in
# config/memory/global.md (installed by the `memory` step). This step links the full
# skill into the agent skill directories as a LIVE symlink so sync updates apply instantly.

install_opinions() {
  local skill="$REPO_ROOT/config/skills/opinions"

  # Claude Code reads ~/.claude/skills/<name>/SKILL.md
  link "$skill" "$HOME/.claude/skills/opinions"
  # Shared location other agents (Codex/opencode/...) scan
  link "$skill" "$HOME/.agents/skills/opinions"

  ok "OPINIONS skill linked (live). Core stances are also in global memory."
  info "Update it from Kun's latest writing with: ./scripts/sync-opinions.sh"
}
