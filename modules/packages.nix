{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2

    brave

    curl
    
    devbox

    firefox
    fd

    gitkraken
    gnome.gnome-tweaks
    gnomeExtensions.useless-gaps

    jetbrains.clion

    kitty

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
