{ pkgs, ... }:

{
  home.packages = with pkgs; [
    baobab
    bat
    black

    curl
    
    devbox

    fd

    libclang

    nix-index

    python311Full
    python311Packages.pip
    python311Packages.pipx

    wget

    xsel
  ];
}

