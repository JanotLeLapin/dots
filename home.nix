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
      nitch lsd pulseaudio-ctl brightnessctl # CLI tools
      pcmanfm waybar pavucontrol layan-gtk-theme tela-circle-icon-theme # GUI
      buildkit docker-compose # Docker

      # Misc
      minecraft
      (opera.override { proprietaryCodecs = true; }) tor-browser-bundle-bin
    ] ++ (importPaths extraPackages);
    file = {
      zellijLayout = {
        source = ./pkgs/zellij/layout.kdl;
        target = ".config/zellij/layouts/default.kdl";
      };
      river = {
        text = specialArgs.format "0x" ./pkgs/river/init.sh;
        target = ".config/river/init";
        executable = true;
      };
    };
  };
  programs = {
    git = import ./pkgs/git;
    kitty = import ./pkgs/kitty;
    wofi = (import ./pkgs/wofi inputs);
    zellij = import ./pkgs/zellij;
    zsh = (import ./pkgs/zsh inputs);
  };
  services = {
    mako = (import ./pkgs/mako inputs);
  };
}
