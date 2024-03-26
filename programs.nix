{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "vim";
      PATH = "$PATH:$HOME/.config/home-manager/bin";
      HISTCONTROL=ignoreboth:erasedups;
      DIRENV_LOG_FORMAT="";
    };
    shellAliases = {
      switch = "home-manager switch";
      ls = "ls -lah --color=auto";
      win-mount = "vmhgfs-fuse .host:/ /home/emusic/Documents/share -o uid=1000 -o gid=1000 -o umask=0022";
      make-keys = "ssh-keygen -t ed25519";
    };
    initExtra = ''
      PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
      # setup direnv
      eval "$(direnv hook bash)"
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
