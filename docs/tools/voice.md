# Voice input (local dictation)

**What it is:** Local speech-to-text so you can *speak* prompts instead of typing —
roughly 3× faster (the Stanford study Kun cites). Transcription runs on-device.

| Mac | App | Notes |
|-----|-----|-------|
| **Apple Silicon** | [OpenSuperWhisper](https://github.com/starmel/OpenSuperWhisper) | Kun's choice; free, open-source, local Whisper. arm64-only. |
| **Intel (x86_64)** | *(none configured)* | OpenSuperWhisper doesn't run on Intel. Use macOS **built-in Dictation** as a fallback. |

> VoiceInk was tried as an Intel alternative and **dropped** — it didn't work reliably.
> If you want, we can evaluate another option (e.g. MacWhisper, OpenWhispr), but nothing
> is installed on Intel by default.

## Install

```bash
./setup.sh voice      # installs OpenSuperWhisper on Apple Silicon; on Intel, prints the fallback
```

On Nix machines, the Apple Silicon host installs the `opensuperwhisper` cask
(`nix/hosts/apple.nix`); the Intel host configures no dictation app.

## Intel fallback: macOS built-in Dictation (zero install)

System Settings → Keyboard → **Dictation** → turn on. Press **Fn twice** to start/stop;
it runs on-device. Not as slick as OpenSuperWhisper, but free and works on Intel.

## First-run setup (OpenSuperWhisper, Apple Silicon)

1. Launch it; grant **Microphone** + **Accessibility / Input Monitoring**.
2. Download a model; set a **global hotkey** (hold-to-record).
3. Fall back to **typing for URLs and file paths**.

### Custom-vocabulary trick

OpenSuperWhisper supports an **initial prompt / vocabulary** in its transcription settings.
Add your jargon — project, tool, and command names — for much better accuracy:

```
WezTerm, tmux, Neovim, Telescope, Claude Code, Codex, opencode, Pi, fnm, Nix,
skills, skill-creator, AXI, gh-axi, chrome-devtools-axi, lavish, lavish-axi,
no-mistakes, gnhf, treehouse, firstmate, worktree, OPINIONS.md, kunchenguid
```

## Gotchas

- **Intel can't run OpenSuperWhisper** — and no third-party app is set there by default.
- **No permissions = silent failure.** If nothing types, re-check Mic + Accessibility.
