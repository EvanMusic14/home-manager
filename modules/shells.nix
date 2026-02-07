{
  config,
  lib,
  pkgs,
  nixgl,
  ...
}:

let
  sessionVariables = {
    EDITOR = "nvim";
    PATH = "$PATH:$HOME/.config/home-manager/bin:$HOME/.nix-profile/bin:$HOME/.local/bin";
    HISTCONTROL = "ignoreboth:erasedups";
    DIRENV_LOG_FORMAT = "";
  };
  shellAliases = {
    cat = "bat";
    db = "devbox";
    clean-docker = "docker system df && docker container prune -f && docker image prune -f && docker builder prune -f && docker volume prune -a -f && docker system df";
    kubectl = "microk8s.kubectl";
    ls = "ls -lah --color=auto --group-directories-first";
    make-keys = "ssh-keygen -t rsa -b 4096";
    switch = "home-manager switch --flake $HOME/.config/home-manager#$USER";
    rebuild = "sudo nixos-rebuild switch --flake $HOME/.config/nixos#$USER";
  };
in
{
  nixGL.packages = nixgl.packages;

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enable
  programs.zsh = {
    enable = true;
    sessionVariables = sessionVariables;
    shellAliases = shellAliases;
    autosuggestion.enable = true;
    history.ignoreAllDups = true;
    oh-my-zsh = {
      enable = true;
      theme = "af-magic";
    };
    initContent = ''
      # Custom file to put things that shouldnt be public
      if [[ -f $HOME/.zshrc_secrets ]]; then . $HOME/.zshrc_secrets; fi
    '';
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.bash.enable
  programs.bash = {
    enable = true;
    sessionVariables = sessionVariables;
    shellAliases = shellAliases;
    initExtra = ''
      # Custom file to put things that shouldnt be public
      if [[ -f $HOME/.bashrc_secrets ]]; then . $HOME/.bashrc_secrets; fi
    '';
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.starship.enable
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.kitty.enable
  programs.kitty = {
    package = config.lib.nixGL.wrap pkgs.kitty;
    enable = true;
    themeFile = "kanagawa";
    shellIntegration = {
      enableZshIntegration = true;
    };
    settings = {
      active_border_color = "#44ffff";
      background_blur = "64";
      background_opacity = "0.9";
      enabled_layouts = "Tall, *";
      shell = "zsh";
      single_windows_margin_width = 1;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      window_border_width = "1pt";
      window_margin_width = "10";
    };
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.wezterm.enable
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./configs/wezterm/wezterm.lua;
  };
}
