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
      discord = import ./pkgs/discord inputs;
      river = import ./pkgs/river inputs;
      zellijLayout = import ./pkgs/zellij/layout.nix;

      wallpaper = {
        source = ./wallpaper.png;
        target = ".wallpaper";
      };
    };
  };
  gtk = import ./pkgs/gtk inputs;
  programs = {
    git = import ./pkgs/git;
    kitty = import ./pkgs/kitty;
    starship = import ./pkgs/starship;
    vscode = (import ./pkgs/vscode inputs);
    waybar = (import ./pkgs/waybar inputs);
    wofi = (import ./pkgs/wofi inputs);
    zellij = import ./pkgs/zellij;
    zsh = (import ./pkgs/zsh inputs);
  };
  services = {
    mako = (import ./pkgs/mako inputs);
    gammastep = import ./pkgs/gammastep;
  };
  wayland.windowManager.hyprland = import ./pkgs/hyprland;
}
