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

    git
    gitkraken
    gnumake

    jetbrains.clion

    neovim

    open-vm-tools

    python311Full
    python311Packages.argcomplete
    python311Packages.pipx
    python311Packages.selenium

    ssm-session-manager-plugin

    vim

    wget
  ];
}
