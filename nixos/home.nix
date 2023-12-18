{ config, pkgs, ... } @ inputs:

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
      git nitch home-manager
      pulseaudio-ctl brightnessctl blueberry tor-browser-bundle-bin shotman
      buildkit docker-compose
      pavucontrol
      layan-gtk-theme tela-circle-icon-theme
      kitty pcmanfm wofi waybar mako hyprpaper lsd zellij
      minecraft
      (opera.override { proprietaryCodecs = true; })
    ] ++ (importPaths extraPackages);
  };
  programs = {
    git = import ./pkgs/git;
    kitty = import ./pkgs/kitty;
    wofi = import ./pkgs/wofi;
    zellij = import ./pkgs/zellij;
    zsh = (import ./pkgs/zsh inputs);
  };
}
