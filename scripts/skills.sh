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
}
