# home-manager

## Steps without clone
- `sudo apt install curl -y && sh <(curl -L https://nixos.org/nix/install) --daemon --yes`

- `mv ~/.bashrc ~/.bashrc.backup && mv ~/.profile ~/.profile.backup && nix --extra-experimental-features 'nix-command flakes' run github:EvanMusic14/home-manager/main#homeConfigurations."emusic".activationPackage`

## Steps with clone
- `ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519`
- Add public key to git
- `cd ~/.config`
- `sudo apt install git -y && git clone git@github.com:EvanMusic14/home-manager.git`
- `cd home-manager`
- `./bin/setup`

## Resources
https://www.chrisportela.com/posts/home-manager-flake/

https://gvolpe.com/blog/nix-flakes/
