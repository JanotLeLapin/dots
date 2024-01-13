{ pkgs, ... } @ inputs: let
  listImport = path: modules: (map (module: import (./. + "/${path}/${module}") inputs) modules);
  attrImport = path: modules: pkgs.lib.genAttrs modules (module: import (./. + "/${path}/${module}") inputs);
in {
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
    ] ++ listImport "pkgs" [ "jdtls" "thorium" "gdlauncher" ];
    file = attrImport "config" [ "river" "zellij" "wallpaper" ];
  };

  gtk = import ./gtk inputs;
  wayland.windowManager.hyprland = import ./hyprland;

  programs = attrImport "programs" [ "git" "kitty" "starship" "vscode" "waybar" "wofi" "zellij" "zsh" ];
  services = attrImport "services" [ "mako" "gammastep" ];

  xdg.desktopEntries = {
    i2p-browser = {
      name = "I2P Browser";
      genericName = "Web Browser";
      exec = "${pkgs.mullvad-browser}/bin/mullvad-browser -p i2p";
      categories = [ "Application" "Network" "WebBrowser" ];
    };
  };
}
