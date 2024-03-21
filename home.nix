{ config, pkgs, ... }:

{
  home.username = "emusic";
  home.homeDirectory = "/home/emusic";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    vim
    jetbrains.clion
    gitkraken
    git
  ];

 programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "vim";
    };
    initExtra = ''
      PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
