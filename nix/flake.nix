{
  description = "gokutheengineer — reproducible macOS setup (nix-darwin + home-manager) for Intel + Apple Silicon";

  inputs = {
    # Pinned to the 26.05 release line — the LAST nixpkgs release that supports
    # x86_64-darwin (Intel). Keeps both hosts on a stable, reproducible base.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, nix-darwin, home-manager }:
    let
      # One helper to build a host. We have two: Intel (current Mac) and Apple Silicon (new).
      mkHost = { system, username, hostModule }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit inputs username; };
          modules = [
            ./modules/darwin.nix          # shared system config (defaults, homebrew, fonts)
            hostModule                     # per-host (arch) overrides
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit username; };
              home-manager.users.${username} = import ./modules/home.nix;
            }
          ];
        };
    in {
      darwinConfigurations = {
        # Current Intel i9 Mac (later handed to a teammate). Apply with: #intel
        intel = mkHost {
          system = "x86_64-darwin";
          username = "gokhansagirlar";
          hostModule = ./hosts/intel.nix;
        };

        # New Apple Silicon laptop. Apply with: #apple
        apple = mkHost {
          system = "aarch64-darwin";
          username = "gokhansagirlar"; # TODO: set to the new Mac's macOS username
          hostModule = ./hosts/apple.nix;
        };
      };
    };
}
