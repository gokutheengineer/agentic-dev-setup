#!/usr/bin/env bash
# skills CLI (vercel-labs/skills) — manager for the open agent-skills ecosystem.
# It runs on-demand via npx, so there's nothing to globally install — we just
# make sure node/npx exist, warm it, and add a convenience `skills` alias.

install_skills() {
  if ! have node || ! have npx; then
    brew_install node
  fi
  ok "node $(node --version) / npx present"

  info "Verifying skills CLI resolves via npx (downloads on first run)..."
  if npx -y skills@latest --help >/dev/null 2>&1; then
    ok "skills CLI works:  npx skills <command>"
  else
    warn "skills CLI did not run — check network / node version"
  fi

  # Convenience `skills` alias lives in our shell entrypoint; wire it into ~/.zshrc.
  ensure_shell_sourced

  # skill-creator (by Anthropic): teaches the agent to author/optimize skills.
  # Plain doc skill -> installs globally fine. (Its optional PromptScript add-on
  # only installs per-project; the "Failed to install 1" line for it is expected.)
  info "Installing skill-creator globally (anthropics/skills)..."
  CI=1 npx -y skills@latest add anthropics/skills --skill skill-creator -g -y 2>&1 \
    | tr -d '\r' | grep -viE 'Cloning repository|^\s*$' | tail -4 || true
  ok "skill-creator installed globally. Verify: skills list -g"
}
