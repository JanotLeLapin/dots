#!/bin/sh

# Channels
sudo nix-channel --add https://channels.nixos.org/nixos-unstable
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

# NixOS
sudo rm -rf /etc/nixos
sudo ln -s $HOME/nixos /etc/nixos
sudo nixos-generate-config
git add --intent-to-add $HOME/nixos
sudo nixos-rebuild switch --impure
