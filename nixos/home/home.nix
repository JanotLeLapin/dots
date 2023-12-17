{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./kitty.nix
    ./zellij.nix
    ./zsh.nix
  ];

  home.username = "josephd";
  home.homeDirectory = "/home/josephd";
  home.stateVersion = "23.05";
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
