# Channels
sudo nix-channel --add https://channels.nixos.org/nixos-unstable

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://channels.nixos.org/nixos-unstable

sudo nix-channel --update
nix-channel --update

# NixOS
sudo rm -rf /etc/nixos
sudo ln -s $HOME/nixos /etc/nixos
sudo nixos-generate-config
sudo nixos-rebuild switch

# Home manager
home-manager switch
