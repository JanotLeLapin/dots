# Channels
sudo nix-channel --add https://channels.nixos.org/nixos-unstable

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://channels.nixos.org/nixos-unstable

# NixOS
sudo rm -rf /etc/nixos
sudo ln -s ./nixos /etc/nixos
sudo nixos-generate-config
sudo nixos-rebuild switch

# Home manager
home-manager switch
