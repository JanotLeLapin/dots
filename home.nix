{ pkgs, ... } @ inputs: let
  listImport = path: modules: (map (module: import (./. + "/${path}/${module}") inputs) modules);
  attrImport = path: modules: pkgs.lib.genAttrs modules (module: import (./. + "/${path}/${module}") inputs);
in {
  home = {
    username = "josephd";
    homeDirectory = "/home/josephd";
    stateVersion = "23.05";
    packages = with pkgs; [
      nitch lsd pulseaudio-ctl brightnessctl swaybg wl-clipboard grim slurp # CLI tools
      pcmanfm waybar pavucontrol # GUI
      buildkit docker-compose # Docker

      # Misc
      tor-browser-bundle-bin
    ] ++ listImport "pkgs" [ "jdtls" "gdlauncher" ];
    file = attrImport "config" [ "river" "zellij" "wallpaper" ];
  };

  gtk = import ./gtk inputs;
  wayland.windowManager.hyprland = import ./hyprland;

  programs = attrImport "programs" [ "git" "kitty" "neovim" "starship" "vscode" "waybar" "wofi" "zellij" "zsh" ];
  services = attrImport "services" [ "mako" "gammastep" ];

  xdg.desktopEntries = let
    chromium-flags = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  in {
    i2p-browser = {
      name = "I2P Browser";
      genericName = "Web Browser";
      exec = "${pkgs.mullvad-browser}/bin/mullvad-browser -p i2p";
      categories = [ "Application" "Network" "WebBrowser" ];
    };
    firefox = {
      name = "Firefox";
      genericName = "Web Browser";
      exec = "${pkgs.floorp}/bin/floorp";
      categories = [ "Application" "Network" "WebBrowser" ];
    };
    discord = {
      name = "Discord";
      genericName = "Chatting";
      exec = "${pkgs.discord}/bin/discord ${chromium-flags}";
      categories = [ "Application" "Network" ];
    };
    spotify = {
      name = "Spotify";
      genericName = "Music Player";
      exec = "${pkgs.spotify}/bin/spotify ${chromium-flags}";
      categories = [ "Application" "Music" ];
    };
  };
}
