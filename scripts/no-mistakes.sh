#!/usr/bin/env bash
# no-mistakes — a local git proxy / validation pipeline. On `git push no-mistakes`
# (or the /no-mistakes skill) it runs review + tests + docs + lint in an isolated
# worktree, then opens a clean PR and babysits it to merge. Free & open source.
#
# Install reviewed in docs/tools/no-mistakes.md. We pin the link dir to ~/.local/bin
# (on our PATH) so the official script never needs sudo.

install_no_mistakes() {
  local bin="$HOME/.no-mistakes/bin/no-mistakes"
  if [ -x "$bin" ]; then
    ok "no-mistakes already installed ($bin). Re-run installer manually to update."
  else
    info "Installing no-mistakes (downloads release binary from GitHub)..."
    curl -fsSL https://raw.githubusercontent.com/kunchenguid/no-mistakes/main/docs/install.sh \
      | NO_MISTAKES_LINK_DIR="$HOME/.local/bin" sh
  fi
  # Also add the /no-mistakes skill (it lives in kunchenguid/axi) for in-agent use.
  info "Installing the no-mistakes skill globally..."
  CI=1 npx -y skills@latest add kunchenguid/axi --skill no-mistakes -g -y 2>&1 \
    | tr -d '\r' | grep -viE 'Cloning repository|^\s*$' | tail -4 || true
  if [ -x "$bin" ]; then
    ok "no-mistakes ready. In a repo: 'no-mistakes init' then 'git push no-mistakes'."
  fi
}
