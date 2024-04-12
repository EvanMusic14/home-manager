{ config, pkgs, lib, ... }:

{
  imports = [
    ./packages.nix
    ./programs.nix
  ];

  home.username = "emusic";
  home.homeDirectory = "/home/emusic";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the experimental nix-command and flakes
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # After switch check if ssh keys exist if not create them
  home.activation.createSshKey = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    [ ! -f ~/.ssh/id_ed25519.pub ] && ${pkgs.openssh.out}/bin/ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519
  '';
}
