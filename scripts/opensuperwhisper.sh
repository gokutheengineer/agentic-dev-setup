#!/usr/bin/env bash
# OpenSuperWhisper — local voice dictation (Whisper/Parakeet). macOS, Apple Silicon.
# Lets you dictate prompts to agents instead of typing.

install_opensuperwhisper() {
  if [ "$(uname -m)" != "arm64" ]; then
    warn "OpenSuperWhisper requires Apple Silicon (arm64); this machine is $(uname -m) — skipping install."
    warn "It will install automatically when you run setup.sh on an Apple Silicon laptop."
    return 0
  fi
  cask_install opensuperwhisper
  if have_app "OpenSuperWhisper"; then
    ok "OpenSuperWhisper installed. Launch it, grant Microphone + Accessibility perms,"
    ok "then download a model and set your global hotkey in its settings."
  fi
}
