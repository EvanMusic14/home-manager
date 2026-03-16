{ pkgs-unstable, ... }:

{
  home.packages = [
    pkgs-unstable.worktrunk
  ];

  home.file.".config/worktrunk/config.toml".source = ./configs/worktrunk/config.toml;
}
