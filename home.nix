{ pkgs, ... } @ inputs:

let
  extraPackages = [./pkgs/jdtls ./pkgs/thorium ./pkgs/gdlauncher];
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
      nitch lsd pulseaudio-ctl brightnessctl swaybg wl-clipboard grim slurp # CLI tools
      pcmanfm waybar pavucontrol # GUI
      buildkit docker-compose # Docker

      # Misc
      spotify
      tor-browser-bundle-bin
      armcord
    ] ++ (importPaths extraPackages);
    file = {
      discord = import ./config/discord inputs;
      river = import ./config/river inputs;
      zellij = import ./config/zellij;

      wallpaper = {
        source = ./wallpaper.png;
        target = ".wallpaper";
      };
    };
  };
  gtk = import ./pkgs/gtk inputs;
  programs = {
    git = import ./programs/git;
    kitty = import ./programs/kitty;
    starship = import ./programs/starship;
    vscode = import ./programs/vscode inputs;
    waybar = import ./programs/waybar inputs;
    wofi = import ./programs/wofi inputs;
    zellij = import ./programs/zellij;
    zsh = import ./programs/zsh inputs;
  };
  services = {
    mako = import ./services/mako inputs;
    gammastep = import ./services/gammastep;
  };
  wayland.windowManager.hyprland = import ./hyprland;
}
