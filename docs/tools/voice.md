# Voice input (local dictation)

**What it is:** Local speech-to-text so you can *speak* prompts instead of typing —
roughly 3× faster (the Stanford study Kun cites). Transcription runs on-device.

| Mac | App | Notes |
|-----|-----|-------|
| **Apple Silicon** | [OpenSuperWhisper](https://github.com/starmel/OpenSuperWhisper) | Kun's choice; free, open-source, local Whisper. arm64-only. |
| **Intel (x86_64)** | **MacWhisper** + **OpenWhispr** (trial) | Two Intel-compatible apps installed side by side to compare. Pick one later. |

> VoiceInk was tried first and **dropped** (didn't work). Now trialing
> [MacWhisper](https://goodsnooze.com/macwhisper/) (freemium; Homebrew cask) and
> [OpenWhispr](https://openwhispr.com) (open-source; GitHub `.dmg`). After testing, keep
> the winner and remove the other from `scripts/voice.sh` + `nix/hosts/intel.nix`.

## Install

```bash
./setup.sh voice      # Apple Silicon: OpenSuperWhisper. Intel: MacWhisper + OpenWhispr.
```

- **MacWhisper** → Homebrew cask `macwhisper` (also declared in `nix/hosts/intel.nix`).
- **OpenWhispr** → has no cask; `voice.sh` downloads the latest x64 `.dmg` from its GitHub
  release and copies the app to `/Applications`. First launch may need right-click → Open
  (Gatekeeper). Not declared in Nix (no cask) — the bash `voice` step handles it.
- On Apple Silicon, `nix/hosts/apple.nix` installs the `opensuperwhisper` cask.

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
