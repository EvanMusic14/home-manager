{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      aaron-bond.better-comments
      alefragnani.bookmarks
      alefragnani.project-manager
      bbenoist.nix
      christian-kohler.path-intellisense
      eamodio.gitlens
      esbenp.prettier-vscode
      gruntfuggly.todo-tree
      vscodevim.vim
      vscode-icons-team.vscode-icons
      mkhl.direnv
      ms-python.python
      ms-azuretools.vscode-docker
      ms-vscode.cpptools
      ms-vscode.cpptools-extension-pack
      ms-vscode.cmake-tools
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-containers 
      oderwat.indent-rainbow
      usernamehw.errorlens
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
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}

