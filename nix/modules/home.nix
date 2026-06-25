# Shared user environment (home-manager). Applies to both hosts.
# This owns the BASE packages, git, and shell. The bespoke agentic tools and the
# wezterm/tmux/nvim config symlinks stay with the bash setup.sh layer (run afterwards).
{ pkgs, username, ... }:
{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  # Bump only when home-manager instructs; keep stable otherwise.
  home.stateVersion = "25.05";

  # Base CLI toolchain (the stuff our bash scripts used to brew-install).
  home.packages = with pkgs; [
    tmux
    neovim
    ripgrep
    fd
    fzf
    jq
    gh
    fnm          # node version manager (Pi runs on node 22 via this)
    nodejs_22    # default node >=20 -> satisfies gnhf; Pi still uses fnm's node 22
    starship
  ];

  # Global git identity (the GitHub-linked, verified identity).
  programs.git = {
    enable = true;
    settings = {
      user.name = "Gökhan Sağırlar";
      user.email = "118421317+gokutheengineer@users.noreply.github.com";
      init.defaultBranch = "main";
      pull.ff = "only";
      push.autoSetupRemote = true;
    };
  };

  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;        # (older home-manager: enableAutosuggestions)
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -lah";
      gs = "git status";
    };
    # home-manager OWNS ~/.zshrc, so source our agentic shell entrypoint from here
    # (the bash layer detects this and won't also append to ~/.zshrc).
    initContent = ''
      [ -f ~/.config/agentic-dev-setup.zsh ] && source ~/.config/agentic-dev-setup.zsh
    '';
  };
}
