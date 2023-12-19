{ config, pkgs, specialArgs, ... } @ inputs:

let
  extraPackages = [
    ./pkgs/discord
    ./pkgs/gtk
    ./pkgs/jdtls
  ];
  importPaths = (paths: (map (p: import p inputs) paths));
in
{
  home = {
    username = "josephd";
    homeDirectory = "/home/josephd";
    stateVersion = "23.05";
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      nitch lsd pulseaudio-ctl brightnessctl swaybg # CLI tools
      pcmanfm waybar pavucontrol layan-gtk-theme tela-circle-icon-theme # GUI
      buildkit docker-compose # Docker

      # Misc
      minecraft
      (opera.override { proprietaryCodecs = true; }) tor-browser-bundle-bin
    ] ++ (importPaths extraPackages);
    file = {
      river = import ./pkgs/river inputs;
      zellijLayout = import ./pkgs/zellij/layout.nix;

      wallpaper = {
        source = ./wallpaper.png;
        target = ".wallpaper";
      };
    };
  };
  programs = {
    git = import ./pkgs/git;
    kitty = import ./pkgs/kitty;
    vscode = (import ./pkgs/vscode inputs);
    waybar = (import ./pkgs/waybar inputs);
    wofi = (import ./pkgs/wofi inputs);
    zellij = import ./pkgs/zellij;
    zsh = (import ./pkgs/zsh inputs);
  };
  services = {
    mako = (import ./pkgs/mako inputs);
  };
}
