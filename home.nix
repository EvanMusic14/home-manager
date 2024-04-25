{ config, pkgs, lib, ... }:
let
    modules = builtins.readDir ./modules;
    configs = builtins.filter (file: builtins.match ".*\.nix" file != null) (builtins.attrNames modules);
in
{
  # Dynamically import all the nix files in the modules directory
  imports = map (file: import (./modules + "/${file}")) configs;

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
  # Move files so that they do not conflict with the ones created by home manager
  home.activation.moveFiles = lib.hm.dag.entryBefore [ "nix" ] ''
    [[ -f $HOME/.bashrc ]] && [[ ! -f $HOME/.bashrc.backup ]] && mv $HOME/.bashrc $HOME/.bashrc.backup
    [[ -f $HOME/.profile ]] && [[ ! -f $HOME/.profile.backup ]] && mv $HOME/.profile $HOME/.profile.backup
    [[ -f $HOME/.bash_profile ]] && [[ ! -f $HOME/.bash_profile.backup ]] && mv $HOME/.bash_profile $HOME/.bash_profile.backup
  '';
}
