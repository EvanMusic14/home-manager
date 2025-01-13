{ config, lib, pkgs, nixgl, ... }:

let
  sessionVariables = {
    EDITOR = "nvim";
    PATH = "$PATH:$HOME/.config/home-manager/bin:$HOME/.nix-profile/bin:$HOME/.local/bin";
    HISTCONTROL=ignoreboth:erasedups;
    DIRENV_LOG_FORMAT="";

    # hgrex-cli
    HGREX_CLI_CUSTOM_SUBCMD_DIR="$HOME/.hgrex-cli/custom";
    HGREX_CLI_STDOUT_LOG_LEVEL="DEBUG";
    HGREX_CLI_FILE_LOG_LEVEL="WARN";
    HGREX_PROJECT_ROOT="$HOME/Documents/ssp/hgrex";
    CONAN_REVISIONS_ENABLED=1;
  };
  shellAliases = {
    db = "devbox";
    clean-docker = "docker system df && docker container prune -f && docker image prune -f && docker builder prune -f && docker volume prune -a -f && docker system df";
    install-podman = "sudo apt install -y podman";
    kubectl = "microk8s.kubectl";
    ls = "ls -lah --color=auto --group-directories-first";
    make-keys = "ssh-keygen -t rsa -b 4096";
    switch = "home-manager switch --flake $HOME/.config/home-manager#$USER";
    rebuild = "sudo nixos-rebuild switch --flake $HOME/.config/nixos#$USER";
    win-mount = "mkdir -p '/home/emusic/Documents/share' && vmhgfs-fuse .host:/share /home/emusic/Documents/share -o uid=1000 -o gid=1000 -o umask=0022";
  };
in
{
  nixGL.packages = nixgl.packages;

  programs.kitty = {
    package = config.lib.nixGL.wrap pkgs.kitty;
    enable = true;
    # Not sure why this isnt working
    # it is listed in the themes
    # theme = "Kanagawa";
    shellIntegration = {
      enableZshIntegration = true;
    };
    settings = {
      active_border_color = "#44ffff";
      background_blur = "64";
      background_opacity = "0.9";
      # dynamic_background_opacity = "yes";
      enabled_layouts = "Tall, *";
      shell = "zsh";
      single_windows_margin_width = 1;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      window_border_width = "1pt";
      window_margin_width = "10";
    };
  };

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
    initExtra = ''
      # Custom file to put things that shouldnt be public
      if [[ -f $HOME/.zshrc_secrets ]]; then . $HOME/.zshrc_secrets; fi
      # enables hgrex-cli tab-completion
      eval "$(register-python-argcomplete hgrex-cli)"
    '';
  };

  programs.bash = {
    enable = true;
    sessionVariables = sessionVariables;
    shellAliases = shellAliases;
    initExtra = ''
      # Due to the issue of icons disapearing when setting zsh as the default shell
      # I am overcoming this by just calling zsh in the bashrc
      # zsh # Found an alternative to set this in the gnome terminal preferences

      PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\ $ '

      GIT_PROMPT_FILE_NIXOS="/run/current-system/sw/share/bash-completion/completions/git-prompt.sh"
      GIT_PROMPT_FILE_NIX="$HOME/.nix-profile/share/git/contrib/completion/git-prompt.sh"

      if [[ -f "$GIT_PROMPT_FILE_NIXOS" ]]; then
        source "$GIT_PROMPT_FILE_NIXOS"
      elif [[ -f "$GIT_PROMPT_FILE_NIX" ]]; then
        source "$GIT_PROMPT_FILE_NIX"
      fi

      update_prompt() {
        PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'

        if [[ $(command -v __git_ps1) ]]; then
          PS1_CMD1=$(__git_ps1 " (%s)")
          PS1+="\[\e[38;5;247m\]''${PS1_CMD1}\[\e[0m\]"

          if [ -n "$DIRENV_DIR" ]; then
            PS1+="% " # prompt is % in direnv directories
          else
            PS1+="\\$ " # prompt is $ in non-direnv directories
          fi
        fi
      }

      PROMPT_COMMAND='update_prompt'

      # Custom file to put things that shouldnt be public
      if [[ -f $HOME/.bashrc_secrets ]]; then . $HOME/.bashrc_secrets; fi

      # setup direnv
      eval "$(direnv hook bash)"
      # enables hgrex-cli tab-completion
      eval "$(register-python-argcomplete hgrex-cli)"
    '';
  };
}
