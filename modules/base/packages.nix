{ pkgs, ... }:

{
  home.packages = with pkgs; [
    baobab

    curl

    devbox
    devenv

    git

    nixfmt

    (pkgs.wrapHelm pkgs.kubernetes-helm { plugins = [ pkgs.kubernetes-helmPlugins.helm-diff ]; })

    tokei

    unzip

    wget

    yq-go
  ];
}
