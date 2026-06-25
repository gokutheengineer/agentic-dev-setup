#!/usr/bin/env bash
# gnhf — "good night, have fun". Runs an agent in a loop toward an objective until a
# stop condition (iterations / tokens / reported condition). Built for long-running,
# often overnight, tasks. Free & open source.
#
# Requires node >=20 (per its engines field). It does run on 18 in practice, but if
# you hit issues, get node 20+ via a version manager (see docs) rather than replacing
# your global node.

install_gnhf() {
  if ! have npm; then brew_install node; fi

  local major
  major="$(node -p 'process.versions.node.split(".")[0]' 2>/dev/null || echo 0)"
  if [ "$major" -lt 20 ]; then
    warn "gnhf wants node >=20; you have $(node --version). It usually still runs on 18,"
    warn "but if it misbehaves, install node 20+ (e.g. 'brew install fnm' then 'fnm install 20')."
  fi

  if have gnhf; then
    ok "gnhf already installed ($(gnhf --version 2>/dev/null))."
  else
    info "npm install -g gnhf"
    npm install -g gnhf 2>&1 | grep -viE 'EBADENGINE|funding|npm warn' | tail -4 || true
  fi
  have gnhf && ok "gnhf ready. Usage: gnhf \"<objective>\" --max-iterations N"
}
