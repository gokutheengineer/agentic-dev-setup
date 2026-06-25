#!/usr/bin/env bash
# lavish — interactive planning via HTML artifacts. The skill teaches the agent to
# turn plans/comparisons/diffs into a reviewable HTML page (using the project's own
# design system) that you annotate in the browser; the lavish-axi CLI runs on demand
# via npx. Used heavily for planning complex work in the video.
#
# Run explicitly: ./setup.sh lavish

install_lavish() {
  if ! have npx; then brew_install node; fi
  info "Installing lavish skill globally (kunchenguid/lavish-axi)..."
  CI=1 npx -y skills@latest add kunchenguid/lavish-axi --skill lavish -g -y 2>&1 \
    | tr -d '\r' | grep -viE 'Cloning repository|^\s*$' | tail -6 || true
  ok "lavish skill installed. The agent will auto-use it for visual planning."
  info "The lavish-axi CLI runs on demand: npx -y lavish-axi  (no global install needed)."
}
