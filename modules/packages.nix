{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2

    curl
    
    devbox

    firefox
    fd

    gitkraken

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
