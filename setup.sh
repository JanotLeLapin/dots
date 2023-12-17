#!/bin/sh

# NixOS
sudo rm -rf /etc/nixos
sudo ln -s $HOME/nixos /etc/nixos
sudo nixos-generate-config
git add --intent-to-add $HOME/nixos/hardware-configuration.nix
sudo nixos-rebuild switch --impure
