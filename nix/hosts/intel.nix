# Intel i9 host (current Mac; later handed to a teammate).
# x86_64-darwin. Homebrew lives in /usr/local (nix-darwin detects this automatically).
{ ... }:
{
  # Intel-compatible apps. OpenSuperWhisper is arm64-only, so on Intel we use VoiceInk
  # (open-source local dictation) instead. Merges with the shared casks in darwin.nix.
  homebrew.casks = [
    "voiceink"   # voice dictation — Intel-compatible alternative to OpenSuperWhisper
  ];

  # Optional: name the machine (uncomment to set).
  # networking.computerName = "gokhan-intel-i9";
  # networking.hostName = "gokhan-intel-i9";
}
