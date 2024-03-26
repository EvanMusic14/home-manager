{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2

    brave

    cmake
    curl
    
    devbox
    direnv

    firefox

    gcc13
    git
    gitkraken
    gnumake

    jetbrains.clion

    neovim

    open-vm-tools

    python311
    python311Packages.selenium

    ssm-session-manager-plugin

    vim

    wget
  ];
}
