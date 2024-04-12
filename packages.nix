{ pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2

    curl
    
    devbox
    direnv

    firefox

    git
    gitkraken

    jetbrains.clion

    neovim

    python311Full
    python311Packages.argcomplete
    python311Packages.pipx
    python311Packages.selenium

    ssm-session-manager-plugin

    wget
  ];
}
