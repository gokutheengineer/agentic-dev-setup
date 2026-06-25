#!/usr/bin/env bash
# local-skills — install every SKILL.md we author in this repo (config/skills/*) into the
# agent skill directories as LIVE symlinks, so edits in the repo apply immediately.
# (Upstream skills — axi, lavish, no-mistakes, skill-creator — are installed separately
#  via the skills CLI; this only handles the ones we write ourselves.)

install_local_skills() {
  local count=0 name
  for d in "$REPO_ROOT"/config/skills/*/; do
    [ -f "${d}SKILL.md" ] || continue
    name="$(basename "$d")"
    link "${d%/}" "$HOME/.claude/skills/$name"     # Claude Code reads ~/.claude/skills
    link "${d%/}" "$HOME/.agents/skills/$name"      # shared location other agents scan
    count=$((count + 1))
  done
  ok "Linked $count local skill(s) from config/skills/ into agent skill dirs."
  info "Verify: skills list -g"
}
