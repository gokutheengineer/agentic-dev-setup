# Intel i9 host (current Mac; later handed to a teammate).
# x86_64-darwin. Homebrew lives in /usr/local (nix-darwin detects this automatically).
{ ... }:
{
  # No Apple-Silicon-only apps here.
  # OpenSuperWhisper is arm64-only, so it is intentionally NOT installed on Intel.

  # Optional: name the machine (uncomment to set).
  # networking.computerName = "gokhan-intel-i9";
  # networking.hostName = "gokhan-intel-i9";
}
