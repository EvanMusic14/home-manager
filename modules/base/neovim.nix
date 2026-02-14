{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    coc = {
      enable = true;
      settings = {
        "languageserver" = {
          "clangd" = {
            "command" = "${pkgs.clang}/bin/clangd";
            "args" = [
              "--background-index"
              "--clang-tidy"
              "--compile-commands-dir=build"
            ];
            "filetypes" = [
              "cpp"
              "cc"
              "hh"
              "h"
              "c"
            ];
            "rootPatterns" = [
              "CMakeLists.txt"
              "compile_commands.json"
              ".clang-format"
              ".clang-tidy"
            ];
          };
        };
      };
    };

    plugins = with pkgs.vimPlugins; [
      coc-nvim
      coc-clangd
      kanagawa-nvim
      lualine-nvim
      vim-nix
      YankRing-vim
      yazi-nvim
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
      -- Disable mouse 
      vim.opt.mouse = ""
      vim.opt.number = true
      vim.opt.tabstop = 2
      vim.opt.scrolloff = 8
      vim.opt.shiftwidth = 2
      vim.opt.smartindent = true
      vim.opt.smartcase = true
      vim.opt.smarttab = true  


      -- Set relative line numbers by default in Normal mode
      vim.opt.relativenumber = true
      vim.opt.number = true

      -- Use autocmd to switch to absolute line numbers in Insert mode
      vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
          vim.opt.number = true
          vim.opt.relativenumber = false
        end,
      })

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          vim.opt.number = true
          vim.opt.relativenumber = true
        end,
      })


      -- Example for configuring Yazi plugin with Lua
      vim.api.nvim_set_keymap('n', '<leader>y', ':Yazi<CR>', { noremap = true, silent = true })
    '';
  };
}
