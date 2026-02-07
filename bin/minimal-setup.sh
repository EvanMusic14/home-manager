#!/usr/bin/env bash
set -euo pipefail

add_shell_hook() {
  local shell_name=$1
  local file_path=$2

  if [ -f "$file_path" ] && ! grep -q "direnv hook $shell_name" "$file_path"; then
    echo "Setup: Adding direnv shell hook to $shell_name"
    {
      echo
      echo "# direnv"
      echo "eval \"\$(direnv hook $shell_name)\""
    } >> "$file_path"
  elif [ -f "$file_path" ]; then
    echo "Setup: Shell hook already added to $shell_name"
  fi
}

if ! command -v nix >/dev/null 2>&1; then
  echo "Setup: Installing Nix"
  curl -fsSL https://nixos.org/nix/install | sh -s -- --daemon --yes
else
  echo "Setup: Nix is already installed"
fi

nix_conf="$HOME/.config/nix/nix.conf"
features_regex='^experimental-features *=.*\bnix-command\b.*\bflakes\b'

mkdir -p "$(dirname "$nix_conf")"

if ! grep -Eq "$features_regex" "$nix_conf" 2>/dev/null; then
  echo "Setup: Enabling flakes + nix-command"
  {
    echo
    echo "experimental-features = nix-command flakes"
  } >> "$nix_conf"
else
  echo "Setup: flakes + nix-command already enabled"
fi

# Ensure nix is available in this shell
if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi 

nix profile add nixpkgs#git nixpkgs#devenv nixpkgs#direnv

add_shell_hook bash "$HOME/.bashrc"
add_shell_hook zsh "$HOME/.zshrc"

echo "Setup: Visit https://devenv.sh/basics/ to learn more about using devenv"

echo "Setup: Restart you shell to start using your Nix packages"
