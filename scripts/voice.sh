#!/usr/bin/env bash
# Voice input — local dictation so you can speak prompts instead of typing.
# OpenSuperWhisper is Apple-Silicon-only. On Intel we're TRIALING two Intel-compatible
# apps (MacWhisper + OpenWhispr); once a winner is picked, drop the other from here and
# from nix/hosts/intel.nix. (VoiceInk was tried earlier and removed — didn't work.)

# OpenWhispr has no Homebrew cask; install the x64 .dmg from its latest GitHub release.
_install_openwhispr() {
  if have_app "OpenWhispr"; then ok "OpenWhispr already installed"; return; fi
  if ! have gh; then warn "gh not found; install OpenWhispr manually from https://openwhispr.com"; return; fi
  local url; url=$(gh release view -R OpenWhispr/openwhispr --json assets \
    --jq '.assets[] | select(.name|test("^OpenWhispr-[0-9.]+\\.dmg$")) | .url' 2>/dev/null | head -1)
  [ -n "$url" ] || { warn "couldn't resolve OpenWhispr x64 dmg URL"; return; }
  info "Installing OpenWhispr (x64) from GitHub release..."
  curl -fsSL "$url" -o /tmp/openwhispr.dmg || { warn "OpenWhispr download failed"; return; }
  local mp; mp=$(hdiutil attach -nobrowse /tmp/openwhispr.dmg | grep -o '/Volumes/.*' | tail -1)
  cp -R "$mp"/*.app /Applications/ 2>/dev/null
  hdiutil detach "$mp" -quiet 2>/dev/null
  rm -f /tmp/openwhispr.dmg
  have_app "OpenWhispr" && ok "OpenWhispr installed (first launch: right-click > Open if Gatekeeper blocks it)."
}

install_voice() {
  if [ "$(uname -m)" = "arm64" ]; then
    cask_install opensuperwhisper
    if have_app "OpenSuperWhisper"; then
      ok "OpenSuperWhisper installed. Grant Microphone + Accessibility, set a hotkey, pick a model."
    fi
  else
    info "OpenSuperWhisper is Apple-Silicon-only; trialing MacWhisper + OpenWhispr on Intel..."
    cask_install macwhisper
    _install_openwhispr
    info "Test both, keep your favorite, then remove the other from voice.sh + nix/hosts/intel.nix."
    info "Zero-install fallback: macOS built-in Dictation (System Settings > Keyboard > Dictation)."
  fi
}
