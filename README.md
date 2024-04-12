# home-manager

## Steps without clone
- Run single command below
```sh
sudo apt install curl -y \
&& sh <(curl -L https://nixos.org/nix/install) --daemon --yes \
&& source /etc/profile \
&& if [[ -f $HOME/.bashrc ]]; then mv ~/.bashrc ~/.bashrc.backup; fi \
&& if [[ -f $HOME/.profile ]]; then mv ~/.profile ~/.profile.backup; fi \
&& nix --extra-experimental-features 'nix-command flakes' run github:EvanMusic14/home-manager/main#homeConfigurations."emusic".activationPackage \
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
https://www.chrisportela.com/posts/home-manager-flake/

https://gvolpe.com/blog/nix-flakes/
