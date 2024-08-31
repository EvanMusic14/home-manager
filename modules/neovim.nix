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

      local keyset = vim.keymap.set

      function _G.check_back_space()
          local col = vim.fn.col('.') - 1
          return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end
      
      local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
      keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
      keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

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

