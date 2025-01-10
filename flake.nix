{
  description = "Home Manager configuration";

  # Flake inputs
  inputs = {
    # Use stable versions for nixpkgs and home-manager
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { nixpkgs, home-manager, nixgl, ... }: {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    # Home Manager configurations
    homeConfigurations = {
      "emusic" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [ nixgl.overlay ];  # Inject nixgl overlay for OpenGL support
        };

        modules = [
          ./home.nix
          {
            home = {
              username = "emusic";
              homeDirectory = "/home/emusic";
              stateVersion = "24.11";  # Explicit version for user configuration
            };
          }
        ];
      };

      "runner" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };

        modules = [
          ./home.nix
          {
            home = {
              username = "runner";
              homeDirectory = "/home/runner";
              stateVersion = "24.11";  # Specific state version for the runner
            };
          }
        ];
      };
    };
  };
}

