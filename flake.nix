{
  description = "Home Manager configuration";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { nixpkgs, home-manager, nixgl, ... }: 
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [ nixgl.overlay ];
    };
  in {
    homeConfigurations = {
      "emusic" = home-manager.lib.homeManagerConfiguration { 
        pkgs = pkgs;
        extraSpecialArgs = { inherit nixgl; };  # Pass nixgl to home-manager configuration
        modules = [
          ./home.nix
          {
            home = {
              username = "emusic";
              homeDirectory = "/home/emusic";
              stateVersion = "24.11";
            };
          }
        ];
      };

      "runner" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        extraSpecialArgs = { inherit nixgl; };  # Pass nixgl to home-manager configuration
        modules = [
          ./home.nix
          {
            home = {
              username = "runner";
              homeDirectory = "/home/runner";
              stateVersion = "24.11";
            };
          }
        ];
      };
    };
  };
}

