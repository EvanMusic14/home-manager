# home-manager
![Nix and Home Manager install](https://github.com/EvanMusic14/home-manager/actions/workflows/testCommands.yml/badge.svg)

## Steps without clone
- Run either of the single commands below
```sh
sudo apt install curl -y \
&& sh <(curl -L https://nixos.org/nix/install) --daemon --yes \
&& source /etc/profile \
&& if [[ -f $HOME/.bashrc ]]; then mv ~/.bashrc ~/.bashrc.backup; fi \
&& if [[ -f $HOME/.profile ]]; then mv ~/.profile ~/.profile.backup; fi \
&& if [[ -f $HOME/.bash_profile ]]; then mv ~/.bash_profile $HOME/.bash_profile.backup; fi \
&& nix --extra-experimental-features 'nix-command flakes' run github:EvanMusic14/home-manager/main#homeConfigurations."$USER".activationPackage \
&& source $HOME/.bashrc
```
```sh
bash <(curl -L https://raw.githubusercontent.com/EvanMusic14/home-manager/curl-script/bin/setup)
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
https://www.chrisportela.com/posts/home-manager-flake/

https://gvolpe.com/blog/nix-flakes/

https://nix-community.github.io/home-manager/release-notes.xhtml#sec-release-22.11-highlights
