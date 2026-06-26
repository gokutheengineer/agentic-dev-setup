# Intel i9 host (current Mac; later handed to a teammate).
# x86_64-darwin. Homebrew lives in /usr/local (nix-darwin detects this automatically).
{ ... }:
{
  # No Intel-only apps configured. (Voice dictation deferred — VoiceInk, MacWhisper, and
  # OpenWhispr were all tried and removed for now; revisit later.)

  # Optional: name the machine (uncomment to set).
  # networking.computerName = "gokhan-intel-i9";
  # networking.hostName = "gokhan-intel-i9";
}
