{ ... }:

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
    grep = "rg";
    la = "eza --icons --group-directories-first -a";
    ll = "eza --icons --group-directories-first -lh";
    lla = "eza --icons --group-directories-first -lah";
    ls = "eza --icons --group-directories-first";
    make-keys = "ssh-keygen -t rsa -b 4096";
    switch-base = "home-manager switch --flake $HOME/.config/home-manager#$USER-base";
    switch-gui = "home-manager switch --flake $HOME/.config/home-manager#$USER-gui";
    rebuild = "sudo nixos-rebuild switch --flake $HOME/.config/nixos#$USER";
  };
in
{
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

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.fish.enable
  programs.fish = {
    enable = true;
    shellAliases = shellAliases;
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.nix-your-shell.enable
  programs.nix-your-shell = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    nix-output-monitor.enable = true;
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.starship.enable
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enable
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    history.ignoreAllDups = true;
    sessionVariables = sessionVariables;
    shellAliases = shellAliases;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "af-magic";
    };
    initContent = ''
      # Custom file to put things that shouldnt be public
      if [[ -f $HOME/.zshrc_secrets ]]; then . $HOME/.zshrc_secrets; fi
    '';
  };
}
