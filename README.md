# home-manager

## Steps
- `sudo apt install curl -y && sh <(curl -L https://nixos.org/nix/install) --daemon --yes`

- `nix --extra-experimental-features 'nix-command flakes' run github:EvanMusic14/home-manager/testing#homeConfigurations."emusic".activationPackage`

## Resources
https://www.chrisportela.com/posts/home-manager-flake/
