{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "vim";
      PATH = "$PATH:$HOME/.config/home-manager/bin:$HOME/.local/bin";
      HISTCONTROL=ignoreboth:erasedups;
      DIRENV_LOG_FORMAT="";

      # hgrex-cli
      HGREX_CLI_CUSTOM_SUBCMD_DIR="$HOME/.hgrex-cli/custom";
      HGREX_CLI_STDOUT_LOG_LEVEL="DEBUG";
      HGREX_CLI_FILE_LOG_LEVEL="WARN";
      HGREX_PROJECT_ROOT="$HOME/Documents/ssp/hgrex";
      CONAN_TOKEN="";
      CONAN_USER="";
      CONAN_REVISIONS_ENABLED=1;
    };
    shellAliases = {
      switch = "home-manager switch";
      ls = "ls -lah --color=auto";
      win-mount = "mkdir -p '/home/emusic/Documents/share' && vmhgfs-fuse .host:/share /home/emusic/Documents/share -o uid=1000 -o gid=1000 -o umask=0022";
      make-keys = "ssh-keygen -t ed25519";
    };
    initExtra = ''
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

      # setup direnv
      eval "$(direnv hook bash)"
      # enables hgrex-cli tab-completion
      eval "$(register-python-argcomplete hgrex-cli)"
    '';
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    settings = {
      background = "dark";
      mouse = "a";
      number = true;
      relativenumber = true;
      tabstop = 2;
    }; 
  };

  programs.git = {
    enable = true;
    userName = "Evan Music";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
  };
}