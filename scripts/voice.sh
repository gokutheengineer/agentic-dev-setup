#!/usr/bin/env bash
# Voice input — local dictation so you can speak prompts instead of typing.
# Arch-dependent because OpenSuperWhisper is Apple-Silicon-only:
#   Apple Silicon -> OpenSuperWhisper (Kun's choice)
#   Intel (x86_64) -> VoiceInk (open-source, local Whisper, Intel-compatible)

install_voice() {
  if [ "$(uname -m)" = "arm64" ]; then
    cask_install opensuperwhisper
    if have_app "OpenSuperWhisper"; then
      ok "OpenSuperWhisper installed. Grant Microphone + Accessibility, set a hotkey, pick a model."
    fi
  else
    info "OpenSuperWhisper is Apple-Silicon-only; installing VoiceInk (Intel-compatible)..."
    cask_install voiceink
    if have_app "VoiceInk"; then
      ok "VoiceInk installed. Grant Microphone + Accessibility, download a model, set a hotkey."
    fi
  fi
}
