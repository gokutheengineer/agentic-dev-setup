#!/usr/bin/env bash
# AXI — Agent eXperience Interface. A skill teaching agents to build/review
# ergonomic, token-efficient CLIs. Installed globally via the skills CLI.

install_axi() {
  if ! have npx; then brew_install node; fi
  info "Installing AXI skill globally (all agents)..."
  # CI=1 quiets the npx spinner; -g global, -y non-interactive, --skill axi (repo also has no-mistakes)
  CI=1 npx -y skills@latest add kunchenguid/axi --skill axi -g -y 2>&1 | tail -8
  ok "AXI skill installed. Verify: skills list -g"
}
