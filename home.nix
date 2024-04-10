{ config, pkgs, ... }:

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

  home.activation.sshkeys = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    [ ! -f ~/.ssh/id_ed25519.pub ] && ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519
  '';
}
