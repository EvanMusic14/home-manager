{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        aaron-bond.better-comments
        # asvetliakov.vscode-neovim
        christian-kohler.path-intellisense
        esbenp.prettier-vscode
        gruntfuggly.todo-tree
        jnoortheen.nix-ide
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
        rust-lang.rust-analyzer
      ];
      userSettings = builtins.fromJSON (builtins.readFile ./configs/vscode/settings.json);
    };
  };
}
