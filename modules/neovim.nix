{pkgs, ...}:


{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    coc = {
      enable= true;
      settings = {
        "keymap.acceptSuggestion" = "<Tab>"; 

      };
    };

    plugins = with pkgs.vimPlugins; [
      coc-nvim
      kanagawa-nvim
      lualine-nvim
      vim-nix
      YankRing-vim
    ];

    extraLuaConfig = ''
      require('lualine').setup {
        options = {
          theme = 'auto', -- Automatically selects a theme based on your colorscheme
        }
      }

      require('kanagawa').setup({
        transparent = true
      })
      vim.cmd('colorscheme kanagawa')

      vim.opt.clipboard:append("unnamedplus")
      vim.opt.expandtab = true
      vim.opt.termguicolors = true
      vim.opt.mouse = "a"
      vim.opt.number = true
      vim.opt.tabstop = 2
      vim.opt.scrolloff = 8
      vim.opt.shiftwidth = 2
      vim.opt.smartindent = true
      vim.opt.smartcase = true
      vim.opt.smarttab = true  
    '';
  };
}
