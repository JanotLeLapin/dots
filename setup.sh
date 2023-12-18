#!/bin/sh

# Generate hardware config
sudo nixos-generate-config
cp /etc/nixos/hardware-configuration.nix .
git add --intent-to-add ./hardware-configuration.nix

sudo nixos-rebuild switch --flake . --impure
