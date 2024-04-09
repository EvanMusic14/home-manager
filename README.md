# home-manager

## Steps
- Run `ssh-keygen -t ed25519`
  - Add public key to git
- Run commands below
```
cd ~/.config
sudo apt install git -y && git clone git@github.com:EvanMusic14/home-manager.git
cd home-manager
./bin/setup
```

## Resources
https://www.chrisportela.com/posts/home-manager-flake/
