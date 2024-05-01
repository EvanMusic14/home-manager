{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set clipboard+=unnamedplus
      set expandtab
      set termguicolors
      set background=dark
      set mouse=a
      set number
      set relativenumber
      set tabstop=2
      set scrolloff=8
      set shiftwidth=2
      set smartindent
      set smartcase
      set smarttab
    '';
  };

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

  programs.git = {
    enable = true;
    userName = "Evan Music";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
