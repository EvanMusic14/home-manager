let
  sessionVariables = {
    EDITOR = "vim";
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
    install-docker = ''
        sudo apt-get update
        sudo apt-get install ca-certificates
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc
        echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
            $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable\" | \
            sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker
    '';
    install-podman = "sudo apt install -y podman";
    kubectl = "microk8s.kubectl";
    ls = "ls -lah --color=auto --group-directories-first";
    make-keys = "ssh-keygen -t rsa -b 4096";
    switch = "home-manager switch";
    win-mount = "mkdir -p '/home/emusic/Documents/share' && vmhgfs-fuse .host:/share /home/emusic/Documents/share -o uid=1000 -o gid=1000 -o umask=0022";
  };
in
{
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
