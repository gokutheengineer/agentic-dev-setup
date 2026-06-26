# Intel i9 host (current Mac; later handed to a teammate).
# x86_64-darwin. Homebrew lives in /usr/local (nix-darwin detects this automatically).
{ ... }:
{
  # Intel dictation trial. OpenSuperWhisper is arm64-only; VoiceInk was tried and dropped.
  # Now trialing MacWhisper (cask) + OpenWhispr (no cask -> installed by setup.sh voice).
  # Once a winner is chosen, keep one and drop the rest.
  homebrew.casks = [
    "macwhisper"
  ];

  # Optional: name the machine (uncomment to set).
  # networking.computerName = "gokhan-intel-i9";
  # networking.hostName = "gokhan-intel-i9";
}
