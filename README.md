# Janot's dotfiles

My configuration files for NixOS, Hyprland, Neovim, and more.

## Setup

*I'm assuming you're running NixOS*

1. Clone this repository in your home directory
2. Delete the `/etc/nixos` directory (you can create a backup if you're scared)
3. Create a symlink for your NixOS configuration:
```sh
sudo ln -s ~/nixos /etc/nixos
```
4. Run the NixOS hardware scan:
```sh
sudo nixos-generate-config
```
5. Build your system:
```sh
sudo nixos-rebuild switch
```
6. Build your home manager setup:
```sh
sudo home-manager build switch
```

You're good to go.
