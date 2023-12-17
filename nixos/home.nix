{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.josephd = { pkgs, ... }: {
    imports = [
      ./eww.nix
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
  };
}
