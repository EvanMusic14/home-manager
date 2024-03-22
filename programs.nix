{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "vim";
      PATH = "$PATH:$HOME/.config/home-manager/bin";
    };
    shellAliases = {
      switch = "home-manager switch";
      ls = "ls -lah --color=auto";
    };
    initExtra = ''
      PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    '';
  };

  programs.git = {
    enable = true;
    userName = "evanmusic14";
    userEmail = "evan.music14@gmail.com";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
  };
}
