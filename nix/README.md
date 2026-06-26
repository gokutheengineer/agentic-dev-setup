# Nix base layer (nix-darwin + home-manager)

The **reproducible macOS base** for this setup, declared with Nix. It's the declarative
counterpart to the imperative `setup.sh` — inspired by
[Kun's reproducible-Mac post](https://blog.kunchenguid.com/p/how-i-built-a-reproducible-mac-setup).

> Status: **authored, not yet applied.** Validate with `build` before any `switch`. The
> first `build` may surface 1–3 option/version tweaks (nix-darwin/home-manager move fast);
> that's expected and easy to fix.

## Two layers, clean split

| Layer | Owns | Where |
|-------|------|-------|
| **Nix** (this dir) | macOS defaults, base CLI packages, fonts, global git, shell (zsh + starship + plugins), GUI casks | `nix/` |
| **bash** (`../setup.sh`) | bespoke agentic tools (skills, opinions, no-mistakes, treehouse, gnhf, firstmate, Pi), memory symlinks, wezterm/tmux/nvim **config** symlinks | `../scripts/` |

They compose: Nix installs the base, then the bash layer adds the agentic tools (its
base-tool steps skip anything Nix already provides).

## Two hosts (multi-arch)

| Attr | Machine | System |
|------|---------|--------|
| `#intel` | current Intel i9 Mac (later: teammate) | `x86_64-darwin` |
| `#apple` | new Apple Silicon laptop | `aarch64-darwin` |

Shared config lives in `modules/`; per-arch differences go in `hosts/` (e.g. an
Apple-Silicon-only cask would live only in `hosts/apple.nix`).

## File map

```
nix/
├── flake.nix            inputs (nixpkgs, nix-darwin, home-manager) + the 2 hosts
├── modules/
│   ├── darwin.nix       shared SYSTEM config: macOS defaults, homebrew, fonts
│   └── home.nix         shared USER config: packages, git, zsh, starship
└── hosts/
    ├── intel.nix        x86_64-darwin specifics
    └── apple.nix        aarch64-darwin specifics
../setup/mac.sh          fresh-Mac bootstrap (installs Nix, switches, runs agentic layer)
```

## Validate WITHOUT changing your machine (do this first)

```bash
# Requires Nix installed (additive; doesn't change your tools). See bootstrap below.
cd nix
nix flake check                       # evaluates the flake
darwin-rebuild build --flake .#intel  # builds the Intel config — NO switch, nothing applied
darwin-rebuild build --flake .#apple  # builds the Apple Silicon config
```

`build` produces the result without activating it. This is how we confirm the config is
good before converging any real machine.

## Apply (converge a machine) — only when ready

```bash
# Easiest: the bootstrap script auto-detects arch and runs both phases.
../setup/mac.sh

# Or manually, first time (nix-darwin not yet active):
sudo nix run nix-darwin -- switch --flake .#apple     # or .#intel

# Subsequent changes:
sudo darwin-rebuild switch --flake .#apple
darwin-rebuild --rollback                              # undo a bad change
```

## Making changes (the whole point)

You don't hand-write Nix — describe what you want and let the agent edit these files:
- *"add Docker and Rectangle"* → `homebrew.casks` in `modules/darwin.nix`
- *"add the `bat` CLI"* → `home.packages` in `modules/home.nix`
- *"turn off dark mode"* → `system.defaults.NSGlobalDomain.AppleInterfaceStyle`

Then re-run `darwin-rebuild switch`.

## Gotchas / notes

- **`cleanup = "none"`** (in `darwin.nix`): leaves Homebrew casks not listed here alone —
  **safe for the current Mac**. Switch to `"zap"` only when you want full reproducibility
  (it will uninstall any cask not in the config).
- **Installer:** uses the **official** Nix installer
  (`sh <(curl -L https://nixos.org/nix/install) --daemon`). Determinate's installers
  dropped Intel/`x86_64-darwin` support (both the curl installer and the `.pkg` reject
  Intel Macs), so `nix.enable = true` + flakes are set in `darwin.nix`.
- **home-manager owns `~/.zshrc`** on a Nix machine; it sources our agentic entrypoint via
  `initExtra`. The bash layer detects this and won't fight it.
- **Don't `switch` the current Mac** until we've validated and you're ready — it would
  converge that machine to this config.
- **`stateVersion`** values (`system` / `home`) and a couple option names
  (`autosuggestion.enable`, `initExtra` vs `initContent`) may need a nudge on first
  `build` depending on the pinned nixpkgs — expected.
