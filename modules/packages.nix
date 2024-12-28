{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2

    baobab
    brave

    curl
    
    devbox

    firefox
    fd

    github-desktop
    gitkraken
    gitnuro
    gnome-tweaks

    jetbrains.clion

    nix-index

    obsidian

    python311Full
    python311Packages.argcomplete
    python311Packages.pipx
    python311Packages.selenium

    smartgithg
    ssm-session-manager-plugin

    wget

    xsel
  ];
}

