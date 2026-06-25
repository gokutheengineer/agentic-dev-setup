#!/usr/bin/env bash
# Pi — minimal, self-extensible coding agent harness (by Mario Zechner / earendil-works).
# Tiny 4-tool core (Read/Write/Edit/Bash); extends via TS extensions, skills, templates.
#
# Pi requires node >=22.19.0. This machine's default node is 18 and ~30 other projects
# depend on it, so we DON'T touch the global node. Instead we install fnm (a version
# manager), sandbox node 22 under it, install Pi there, and wrap `pi` to run on node 22.

PI_PKG="@earendil-works/pi-coding-agent"
PI_NODE="22"

install_pi() {
  # 1. fnm — per-shell node version manager; leaves the global node alone.
  if ! have fnm; then brew_install fnm; fi
  ok "fnm present ($(fnm --version 2>/dev/null))"

  # 2. node 22 under fnm (idempotent)
  if fnm list 2>/dev/null | grep -q "v${PI_NODE}\."; then
    ok "node ${PI_NODE}.x already installed under fnm"
  else
    info "Installing node ${PI_NODE} via fnm..."
    fnm install "$PI_NODE"
  fi

  # 3. Pi under node 22 (global to that node; --ignore-scripts is the documented method)
  if fnm exec --using="$PI_NODE" pi --version >/dev/null 2>&1; then
    ok "Pi already installed under node ${PI_NODE} ($(fnm exec --using=$PI_NODE pi --version 2>/dev/null))"
  else
    info "Installing Pi ($PI_PKG) under node ${PI_NODE}..."
    fnm exec --using="$PI_NODE" npm install -g --ignore-scripts "$PI_PKG" 2>&1 \
      | grep -viE 'EBADENGINE|funding|npm warn' | tail -4 || true
  fi

  # 4. `pi` launcher (runs on node 22 without changing your default node)
  ensure_shell_sourced
  if fnm exec --using="$PI_NODE" pi --version >/dev/null 2>&1; then
    ok "Pi ready. Run: pi   (wrapped to node ${PI_NODE} via fnm; your global node stays 18)"
  else
    warn "Pi install couldn't be verified — try: fnm exec --using=$PI_NODE pi --version"
  fi
}
