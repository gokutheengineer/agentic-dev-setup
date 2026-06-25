# Apple Silicon host (new laptop). aarch64-darwin.
# Homebrew lives in /opt/homebrew (nix-darwin detects this automatically).
{ ... }:
{
  # Apple-Silicon-only apps. This list MERGES with the shared casks in modules/darwin.nix.
  homebrew.casks = [
    "opensuperwhisper"   # local voice dictation — arm64 only
  ];

  # Optional: name the machine (uncomment to set).
  # networking.computerName = "gokhan-mac";
  # networking.hostName = "gokhan-mac";
}
