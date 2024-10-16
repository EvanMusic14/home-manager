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

    gitkraken
    github-desktop
    gitnuro
    gnome-tweaks

    jetbrains.clion

    nix-index

    python311Full
    python311Packages.argcomplete
    python311Packages.pipx
    python311Packages.selenium

    ssm-session-manager-plugin

    wget

    xsel
  ];
}

