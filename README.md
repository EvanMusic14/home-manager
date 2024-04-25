# home-manager
![Nix and Home Manager install](https://github.com/EvanMusic14/home-manager/actions/workflows/testCommands.yml/badge.svg)

## Steps without clone
- Run single command below
```sh
sudo apt install curl -y \
&& sh <(curl -L https://nixos.org/nix/install) --daemon --yes \
&& source /etc/profile \
&& nix --extra-experimental-features 'nix-command flakes' run github:EvanMusic14/home-manager/main#homeConfigurations."$USER".activationPackage \
&& source $HOME/.bashrc
```

## Steps with clone
- Run `ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub`
- Add public key to git
- Run command below
```sh
cd $HOME/.config \
&& sudo apt install git -y \
&& git clone git@github.com:EvanMusic14/home-manager.git \
&& cd home-manager \
&& ./bin/setup \
&& source $HOME/.bashrc
```

## Resources
- home-manager/flake config
  - https://www.chrisportela.com/posts/home-manager-flake/
  - https://gvolpe.com/blog/nix-flakes/
  - https://nix-community.github.io/home-manager/release-notes.xhtml#sec-release-22.11-highlights
- podman
  - https://www.reddit.com/r/NixOS/comments/1bh7vy8/does_anyone_have_a_working_example_of_a/
  - https://github.com/FabianKoehnen/rootless-podman-homemanager

- `home.activation` scripts
  - https://github.com/nix-community/home-manager/blob/master/modules/lib/dag.nix
  - https://github.com/nix-community/home-manager/blob/b8b391ad18b2ec47d1e95e247301edd4e8326154/modules/files.nix#L50-L83
