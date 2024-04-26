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

  # Check for programs installed on ubuntu that will conflict with nix packages
  home.activation.checkDuplicates = lib.hm.dag.entryAfter [ "onFilesChange" "reloadSystemd" "installPackages" "createSshKey" ] ''
    toBeRemoved=""
    [[ -f /usr/bin/firefox ]] && toBeRemoved+="firefox "
    [[ -f /usr/bin/curl ]] && toBeRemoved+="curl "
    [[ -f /usr/bin/git ]] && toBeRemoved+="git "
    [[ -f /usr/bin/vim ]] && toBeRemoved+="vim "
    if [[ ! $toBeRemoved == "" ]]; then echo "Warning: There are apt packages installed that may conflict with nix packages" && echo "Run: sudo apt purge --auto-remove $toBeRemoved -y" | xargs; fi
    if [[ -f /snap/bin/firefox ]]; then echo "Warning: There are snap packages installed that may conflict with nix packages" && echo "Run: sudo snap remove --purge firefox"; fi
  '';
  # After switch check if ssh keys exist if not create them
  home.activation.createSshKey = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    [ ! -f ~/.ssh/id_rsa.pub ] && ${pkgs.openssh.out}/bin/ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
  '';
  # Move files so that they do not conflict with the ones created by home manager
  home.activation.moveFiles = lib.hm.dag.entryBefore [ "checkFilesChanged" "checkLinkTargets" "writeBoundary" "installPackages" ] ''
    [[ -f $HOME/.bashrc ]] && [[ ! -f $HOME/.bashrc.backup ]] && mv $HOME/.bashrc $HOME/.bashrc.backup
    [[ -f $HOME/.profile ]] && [[ ! -f $HOME/.profile.backup ]] && mv $HOME/.profile $HOME/.profile.backup
    [[ -f $HOME/.bash_profile ]] && [[ ! -f $HOME/.bash_profile.backup ]] && mv $HOME/.bash_profile $HOME/.bash_profile.backup
  '';
}
