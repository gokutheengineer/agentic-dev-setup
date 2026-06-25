# OpenSuperWhisper

**What it is:** A local macOS voice-dictation app (Whisper + Parakeet models). You
hold a hotkey, speak, and it types the transcription wherever your cursor is — great
for dictating long agent prompts instead of typing them.

## ⚠️ Apple Silicon only

OpenSuperWhisper ships **ARM64 / Apple Silicon only**. On this Intel Mac the installer
**skips automatically** (see `scripts/opensuperwhisper.sh`). It will install when you
run `./setup.sh` on an Apple Silicon machine.

## Install

```bash
./setup.sh opensuperwhisper      # arm64 only; no-op on Intel
# equivalent: brew install --cask opensuperwhisper
```

## First-run setup (on Apple Silicon)

1. Launch **OpenSuperWhisper**.
2. Grant macOS permissions: **Microphone** and **Accessibility/Input Monitoring**
   (System Settings → Privacy & Security). Dictation won't work without these.
3. Download a transcription model in-app (a default Whisper model is fetched on first
   launch; bigger models = better accuracy, slower).
4. Set a **global hotkey** (hold-to-record) in settings.
5. Pick your input device (built-in / Bluetooth / iPhone via Continuity).

## Daily use

- Hold the hotkey, speak your prompt, release — text appears at the cursor.
- Drag-and-drop an audio file onto the app to transcribe a recording.
- Fall back to **typing for URLs and file paths** — don't dictate those.

## The custom-vocabulary trick (the video's "why is transcription so good?")

In the **transcription / model menu** there's an **initial prompt** (a system prompt for
the recognizer). Put your **common vocabulary** there — project names, tool names, jargon —
and transcription accuracy on those terms jumps. Kun credits this for how well it
recognizes names like "lavish-axi", "gh-axi", "treehouse", etc.

Suggested starting vocabulary for this setup:

```
WezTerm, tmux, Neovim, Telescope, Claude Code, Codex, opencode, Pi, fnm,
skills, skill-creator, AXI, gh-axi, chrome-devtools-axi, lavish, lavish-axi,
no-mistakes, gnhf, treehouse, firstmate, worktree, OPINIONS.md, kunchenguid
```

## Gotchas

- **Intel Macs are unsupported** — that's the big one.
- **No permissions = silent failure.** If nothing types, re-check Accessibility +
  Microphone grants.
- First model download can be large; do it on a good connection.
