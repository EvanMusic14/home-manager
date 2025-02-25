{ pkgs, ... }:

{
  programs.vim = {
    enable = true;
    settings = {
      background = "dark";
      mouse = "a";
      number = true;
      relativenumber = true;
      tabstop = 2;
    }; 
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
 
    defaultCommand = "fd --type f";
  };

  programs.nnn = {
    enable = true;
  };

  programs.broot = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Evan Music";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
    extraConfig = {
      push = {
        autoSetupRemote = "true";
      };
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        show_hidden = true;
        sort_dir_first = true;
        show_symlink = true;
        scrolloff = 8;
      };
    };
  };
}

