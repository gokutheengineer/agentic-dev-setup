# Intel i9 host (current Mac; later handed to a teammate).
# x86_64-darwin. Homebrew lives in /usr/local (nix-darwin detects this automatically).
{ ... }:
{
  # No Intel-only apps configured. OpenSuperWhisper is arm64-only; VoiceInk was tried as
  # an Intel alternative and dropped (didn't work). On Intel, use macOS built-in Dictation.

  # Optional: name the machine (uncomment to set).
  # networking.computerName = "gokhan-intel-i9";
  # networking.hostName = "gokhan-intel-i9";
}
