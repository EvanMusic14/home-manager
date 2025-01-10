{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      aaron-bond.better-comments
      asvetliakov.vscode-neovim
      bbenoist.nix
      christian-kohler.path-intellisense
      esbenp.prettier-vscode
      gruntfuggly.todo-tree
      llvm-vs-code-extensions.vscode-clangd
      vscode-icons-team.vscode-icons
      mkhl.direnv
      ms-python.python
      ms-azuretools.vscode-docker
      ms-vscode.cpptools
      ms-vscode.cpptools-extension-pack
      ms-vscode.cmake-tools
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-containers 
      mechatroner.rainbow-csv
    ];
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
}

