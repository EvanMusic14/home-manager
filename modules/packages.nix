{ pkgs, ... }:

{
  home.packages = with pkgs; [
	  attr
    awscli2

    curl
    
    devbox
    direnv

    firefox
    fd

    git
    gitkraken

    jetbrains.clion

    podman
    python311Full
    python311Packages.argcomplete
    python311Packages.pipx
    python311Packages.selenium

    shadow
    ssm-session-manager-plugin

    wget

    xsel
  ];
}
