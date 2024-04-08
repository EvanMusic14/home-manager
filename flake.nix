{
  description = "Home Manager configuration of emusic";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

      homeConfigurations = {
        "emusic" = home-manager.lib.homeManagerConfiguration {

            pkgs = import nixpkgs { system = "x86_64-linux"; };

            modules = [ ./home.nix ];
        };
      };
  };
}
