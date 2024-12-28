{
  description = "Home Manager configuration of emusic";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; # Stable 24.11
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11"; # Stable 24.11
      # url = "github:nix-community/home-manager"; # Unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

    homeConfigurations = {
      # My main configuration
      "emusic" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };

        modules = [
          ./home.nix
          {
            home = {
              username = "emusic";
              homeDirectory = "/home/emusic";
              stateVersion = "23.11";
            };
          }
        ];
      };
      # A configuration needed for github actions to run ci
      "runner" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };

        modules = [
          ./home.nix
          {
            home = {
              username = "runner";
              homeDirectory = "/home/runner";
              stateVersion = "23.11";
            };
          }
        ];
      };
    };
  };
}
