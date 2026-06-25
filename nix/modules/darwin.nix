# Shared macOS system configuration (applies to BOTH Intel and Apple Silicon).
# Per-arch differences live in hosts/{intel,apple}.nix.
{ pkgs, username, ... }:
{
  nixpkgs.config.allowUnfree = true;

  # We use Determinate Systems' Nix installer (recommended on macOS); it manages the
  # daemon and enables flakes itself. So let it own Nix rather than nix-darwin.
  #   -> If you used the OFFICIAL nix installer instead, set: nix.enable = true; and add
  #      nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.enable = false;

  # The primary user (needed for user-scoped defaults + Homebrew).
  system.primaryUser = username;
  users.users.${username}.home = "/Users/${username}";

  # zsh as the system shell (home-manager configures the user side).
  programs.zsh.enable = true;

  # ---------------------------------------------------------------------------
  # macOS system defaults — the "new Mac" niceties Kun automates.
  # ---------------------------------------------------------------------------
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";            # dark mode
      InitialKeyRepeat = 15;                   # fast key repeat (lower = faster)
      KeyRepeat = 2;
      ApplePressAndHoldEnabled = false;        # repeat keys instead of accent popup
      AppleShowAllExtensions = true;
      "com.apple.mouse.tapBehavior" = 1;       # tap-to-click (global)
      "com.apple.swipescrolldirection" = true; # natural scrolling
    };
    dock = {
      autohide = true;
      show-recents = false;
      mru-spaces = false;
      tilesize = 48;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "Nlsv";           # list view
      _FXShowPosixPathInTitle = true;
      FXEnableExtensionChangeWarning = false;
    };
    trackpad = {
      Clicking = true;                          # tap-to-click (trackpad)
      TrackpadThreeFingerDrag = true;
    };
    screencapture.location = "~/Screenshots";
    loginwindow.GuestEnabled = false;
  };

  # ---------------------------------------------------------------------------
  # Homebrew, managed declaratively by nix-darwin (for GUI apps Nix doesn't have).
  # nix-darwin auto-uses the right prefix per arch (/usr/local on Intel,
  # /opt/homebrew on Apple Silicon).
  # ---------------------------------------------------------------------------
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # "none" = leave unlisted casks alone (SAFE — important on the current Mac).
      # Switch to "zap" later for full reproducibility (removes anything not listed).
      cleanup = "none";
    };
    casks = [
      "wezterm"
    ];
    brews = [ ];
  };

  # Fonts (WezTerm bundles JetBrains Mono, but this makes it available everywhere).
  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  # Bump only when nix-darwin tells you to; keep stable otherwise.
  system.stateVersion = 5;
}
