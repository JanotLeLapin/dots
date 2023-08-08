# Janot's dotfiles

My configuration files for NixOS, Hyprland, Neovim, and more.

## Setup

*I'm assuming you're running NixOS*

Clone this repository into your home directory, and run the utility `setup.sh` script I wrote because I'm lazy.

Here's what the script will do to your machine, in order:

1. Add the NixOS unstable & home-manager channels
2. **DELETE** the `/etc/nixos` directory (you can (and probably should) create a backup)
3. Create a symlink for the NixOS config
4. Run the NixOS hardware scan
5. Rebuild your system
6. Rebuild your home manager setup
