# Justins Nix setup

Steps to setup nix on mac

follow instructions on https://github.com/DeterminateSystems/nix-installer

Clone this repo and install `nix-darwin`:
```
mkdir ~/.config
cd ~/.config
git clone https://github.com/bodymindarts/nix-darwin.git
nix run nix-darwin -- switch --flake ~/.config/nix-darwin
```

