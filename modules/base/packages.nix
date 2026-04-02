{ pkgs, pkgs-unstable, ... }:

{
  home.packages = [
    pkgs.baobab

    pkgs.curl

    pkgs.git

    pkgs.kubectl

    pkgs.nixfmt


    (pkgs.wrapHelm pkgs.kubernetes-helm { plugins = [ pkgs.kubernetes-helmPlugins.helm-diff ]; })

    pkgs.tokei

    pkgs.unzip

    pkgs.wget

    pkgs.yq-go

    pkgs-unstable.devenv

    pkgs-unstable.prettier
  ];
}
