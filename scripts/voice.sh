#!/usr/bin/env bash
# Voice input — local dictation so you can speak prompts instead of typing.
# OpenSuperWhisper is Apple-Silicon-only. No Intel dictation app is configured here
# (VoiceInk was tried and dropped — didn't work well), so on Intel we point at macOS's
# built-in Dictation as a zero-install fallback.

install_voice() {
  if [ "$(uname -m)" = "arm64" ]; then
    cask_install opensuperwhisper
    if have_app "OpenSuperWhisper"; then
      ok "OpenSuperWhisper installed. Grant Microphone + Accessibility, set a hotkey, pick a model."
    fi
  else
    warn "OpenSuperWhisper is Apple-Silicon-only; no Intel dictation app is configured."
    info "Fallback on Intel: macOS built-in Dictation (System Settings > Keyboard > Dictation; press Fn twice to start)."
  fi
}
