---
name: nix-setup
description: Manage this Mac's reproducible Nix / nix-darwin configuration — add or remove packages, Homebrew casks, macOS system defaults, fonts, or git/shell settings, then rebuild. Use whenever the user asks to install an app or CLI system-wide, change a macOS setting (dark mode, key repeat, dock, finder, trackpad), or says "add X to my setup" / "update my nix", on a Mac managed by the agentic-dev-setup nix/ flake.
---

# nix-setup — edit the flake, never hand-mutate the Mac

The Mac's base is declarative. To change it you EDIT files in the `agentic-dev-setup`
repo's `nix/` directory, then rebuild. Never `brew install` or `defaults write` directly —
that drifts from the config.

Repo: `~/goku/agentic-dev-setup/nix` (wherever the repo is cloned). Two hosts:
`#intel` (x86_64, current Mac) and `#apple` (aarch64, new Mac).

## Where each kind of change goes

| Want to… | Edit | Example |
|----------|------|---------|
| Add a CLI tool | `modules/home.nix` → `home.packages` | add `bat` to the list |
| Add a GUI app | `modules/darwin.nix` → `homebrew.casks` (shared) or `hosts/{intel,apple}.nix` (arch-specific) | `casks = [ "wezterm" "rectangle" ];` |
| Change a macOS default | `modules/darwin.nix` → `system.defaults.*` | `dock.autohide = false;` |
| Change git/shell | `modules/home.nix` → `programs.git` / `programs.zsh` | add a shell alias |
| Add a font | `modules/darwin.nix` → `fonts.packages` | |

## Apply changes

```bash
cd ~/goku/agentic-dev-setup/nix
# validate first (no activation):
darwin-rebuild build  --flake .#intel        # or .#apple on the new Mac
# then apply:
sudo darwin-rebuild switch --flake .#intel
darwin-rebuild --rollback                     # undo the last switch if needed
```

Always `build` before `switch` when unsure. Pick `#intel` or `#apple` by the machine's
arch (`uname -m`: arm64 → apple, x86_64 → intel).

## Gotchas

- **x86_64-darwin is being sunset** in nixpkgs (26.05 is the last release to support it).
  Relevant for the Intel host's long-term updates.
- `homebrew.onActivation.cleanup = "none"` keeps unlisted casks; switching to `"zap"`
  removes anything not in the config.
- First builds may need an option/`stateVersion` nudge — read the error and adjust the
  matching `.nix` file.
- The bespoke agentic tools (skills, lavish, no-mistakes, treehouse, gnhf, firstmate, Pi)
  are NOT in Nix — they're installed by `../setup.sh`. Don't add those to the flake.
