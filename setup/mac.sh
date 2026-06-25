#!/usr/bin/env bash
#
# mac.sh — fresh-Mac bootstrap. Two phases:
#   1. Nix base layer  (system defaults, packages, git, shell, casks)  -> nix/flake.nix
#   2. Agentic layer   (bespoke AI tools)                              -> ../setup.sh
#
# This APPLIES changes (darwin-rebuild switch). It auto-detects the host by CPU arch:
#   arm64  -> #apple    (new Apple Silicon laptop)
#   x86_64 -> #intel    (current Intel i9 Mac)
#
# DO NOT run this on a machine you're not ready to converge to the config.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ "$(uname -m)" = "arm64" ]; then HOST=apple; else HOST=intel; fi
echo "==> Target host config: #${HOST}  (repo: $REPO)"
printf "This will converge THIS Mac to the Nix config (darwin-rebuild switch). Continue? [y/N] "
read -r ans; [ "$ans" = "y" ] || { echo "Aborted."; exit 1; }

# 0. Xcode CLT (git, cc) — needed before anything.
xcode-select -p >/dev/null 2>&1 || xcode-select --install || true

# 1. Install Nix (Determinate Systems installer — reliable on macOS, flakes on by default).
if ! command -v nix >/dev/null 2>&1; then
  echo "==> Installing Nix (Determinate Systems)..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix \
    | sh -s -- install
  # load nix into this shell
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh 2>/dev/null || true
fi

# 2. Apply the Nix base layer.
if command -v darwin-rebuild >/dev/null 2>&1; then
  echo "==> darwin-rebuild switch --flake ${REPO}/nix#${HOST}"
  sudo darwin-rebuild switch --flake "${REPO}/nix#${HOST}"
else
  # First-ever apply: nix-darwin isn't installed yet, so bootstrap via `nix run`.
  echo "==> Bootstrapping nix-darwin (first run)..."
  sudo nix run nix-darwin -- switch --flake "${REPO}/nix#${HOST}"
fi

# 3. Agentic layer (bespoke tools Nix doesn't manage). Base tools/casks come from Nix,
#    so the relevant setup.sh steps are idempotent (they skip what's already present).
echo "==> Running the agentic layer (${REPO}/setup.sh)..."
"${REPO}/setup.sh" memory skills opinions axi lavish no-mistakes treehouse gnhf firstmate pi

echo "==> Done. Open a new terminal. Future changes: edit nix/ then 'darwin-rebuild switch --flake ${REPO}/nix#${HOST}'."
