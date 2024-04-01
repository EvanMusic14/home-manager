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
      switch = "home-manager switch --extra-experimental-features 'nix-command flakes'";
      ls = "ls -lah --color=auto";
      win-mount = "mkdir -p '/home/emusic/Documents/share' && vmhgfs-fuse .host:/share /home/emusic/Documents/share -o uid=1000 -o gid=1000 -o umask=0022";
      make-keys = "ssh-keygen -t ed25519";
    };
    initExtra = ''
      PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
      # setup direnv
      eval "$(direnv hook bash)"
      # enables hgrex-cli tab-completion
      eval "$(register-python-argcomplete hgrex-cli)"
    '';
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
