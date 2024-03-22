{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmake
    curl
    
    devbox

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

    vim

    wget
  ];
}
