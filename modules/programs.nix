{ pkgs, ... }:

{
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.bat.enable
  programs.bat = {
    enable = true;
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.direnv.enable
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.fd.enable
  programs.fd = {
    enable = true;
    hidden = true;
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.fzf.enable
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    defaultCommand = "fd --type f";
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.k9s.enable
  programs.k9s = {
    enable = true;
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.nix-index.enable
  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.vim.enable
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

  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.yazi.enable
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
