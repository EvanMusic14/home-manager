{ ... }:

{
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.wezterm.enable
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./configs/wezterm/wezterm.lua;
  };
}
