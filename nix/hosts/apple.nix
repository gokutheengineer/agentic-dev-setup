# Apple Silicon host (new laptop). aarch64-darwin.
# Homebrew lives in /opt/homebrew (nix-darwin detects this automatically).
{ ... }:
{
  # No Apple-Silicon-only apps configured. (Voice dictation is deferred — to be
  # decided later; OpenSuperWhisper would go here as a cask when revisited.)

  # Optional: name the machine (uncomment to set).
  # networking.computerName = "gokhan-mac";
  # networking.hostName = "gokhan-mac";
}
