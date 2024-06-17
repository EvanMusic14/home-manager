# home-manager
![Nix and Home Manager install](https://github.com/EvanMusic14/home-manager/actions/workflows/testCommands.yml/badge.svg)

## Steps without clone
- Run command below
```sh
wget --output-document=/dev/stdout https://nixos.org/nix/install | sh -s -- --daemon --yes \
&& source /etc/profile \
&& nix --extra-experimental-features 'nix-command flakes' run github:EvanMusic14/home-manager/main#homeConfigurations."$USER".activationPackage
```

## Steps with clone
- Run `ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa && cat ~/.ssh/id_rsa.pub`
- Add public key to GitHub
- Run command below
```sh
wget --output-document=/dev/stdout https://nixos.org/nix/install | sh -s -- --daemon --yes \
&& source /etc/profile \
&& nix-shell -p home-manager git \
    --run "git clone git@github.com:EvanMusic14/home-manager.git ~/.config/home-manager \
    && home-manager switch --extra-experimental-features 'nix-command flakes'"
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
