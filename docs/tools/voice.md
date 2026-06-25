# Voice input (local dictation)

**What it is:** Local speech-to-text so you can *speak* prompts instead of typing —
roughly 3× faster (the Stanford study Kun cites). Transcription runs on-device.

The app is **arch-dependent**, because Kun's pick (OpenSuperWhisper) is Apple-Silicon-only:

| Mac | App | Why |
|-----|-----|-----|
| **Apple Silicon** | [OpenSuperWhisper](https://github.com/starmel/OpenSuperWhisper) | Kun's choice; free, open-source, local Whisper. arm64-only. |
| **Intel (x86_64)** | [VoiceInk](https://tryvoiceink.com/) | Open-source, local Whisper, types at cursor; supports Intel + Apple Silicon. |

## Install

```bash
./setup.sh voice      # picks the right app for this Mac's architecture
```

- On Nix machines it also comes from the flake: `opensuperwhisper` cask in
  `nix/hosts/apple.nix`, `voiceink` cask in `nix/hosts/intel.nix`.

## First-run setup (either app)

1. Launch the app.
2. Grant macOS **Microphone** + **Accessibility / Input Monitoring** (System Settings →
   Privacy & Security). Dictation silently does nothing without these.
3. Download a transcription model in-app (bigger = more accurate, slower).
4. Set a **global hotkey** (hold-to-record).

## Daily use

- Hold the hotkey, speak, release → text appears at the cursor.
- Fall back to **typing for URLs and file paths** — don't dictate those.

### Custom-vocabulary trick (better accuracy)

Both apps support an **initial prompt / vocabulary** in their transcription settings. Add
your jargon — project, tool, and command names — so they transcribe correctly. Starter set:

```
WezTerm, tmux, Neovim, Telescope, Claude Code, Codex, opencode, Pi, fnm, Nix,
skills, skill-creator, AXI, gh-axi, chrome-devtools-axi, lavish, lavish-axi,
no-mistakes, gnhf, treehouse, firstmate, worktree, OPINIONS.md, kunchenguid
```

## Gotchas

- **Intel can't run OpenSuperWhisper** — that's why VoiceInk is the Intel pick.
- **No permissions = silent failure.** If nothing types, re-check Mic + Accessibility.
- VoiceInk requires macOS ≥ 14.
