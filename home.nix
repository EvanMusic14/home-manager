{ config, pkgs, lib, ... }:
let
    username = "emusic";
    modules = builtins.readDir ./modules;
    configs = builtins.filter (file: builtins.match ".*\.nix" file != null) (builtins.attrNames modules);
in
{
  imports = map (file: import (./modules + "/${file}")) configs;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

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
