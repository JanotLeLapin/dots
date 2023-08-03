# Janot's dotfiles

My configuration files for NixOS, Hyprland, Neovim, and more.

## Setup

*I'm assuming you're running NixOS*

1. Clone this repository in your home directory
2. Create a symlink for your NixOS configuration:
```sh
sudo ln -s ~/nixos /etc/nixos
```
3. Build your system:
```sh
sudo nixos-rebuild switch
```
4. Build your home manager setup:
```sh
sudo home-manager build switch
```

You're good to go.
