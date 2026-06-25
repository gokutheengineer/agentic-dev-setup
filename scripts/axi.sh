#!/usr/bin/env bash
# AXI — Agent eXperience Interface. Design standards (10 principles) for building
# CLIs that agents use efficiently. The guidance skill installs globally; AXI's
# executable (PromptScript) tooling is added per-project where you build a CLI.
#
# NOTE: not in setup.sh's default TOOLS list — AXI is mostly a per-project concern.
# Run explicitly with: ./setup.sh axi

install_axi() {
  if ! have npx; then brew_install node; fi
  info "Installing AXI guidance skill globally (kunchenguid/axi)..."
  CI=1 npx -y skills@latest add kunchenguid/axi --skill axi -g -y 2>&1 \
    | tr -d '\r' | grep -viE 'Cloning repository|^\s*$' | tail -6 || true
  ok "AXI guidance installed globally. (PromptScript tooling installs per-project.)"
  info "Browse/install AXI tools per-project from the catalog: https://axi.md"
}
