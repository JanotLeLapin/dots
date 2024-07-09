{ pkgs, wayland, ... } @ inputs: let
  listImport = path: modules: (map (module: import (./. + "/${path}/${module}") inputs) modules);
  attrImport = path: modules: pkgs.lib.genAttrs modules (module: import (./. + "/${path}/${module}") inputs);
in {
  home = {
    username = "josephd";
    homeDirectory = "/home/josephd";
    stateVersion = "23.05";
    packages = with pkgs; [
      nitch lsd # CLI tools
      pcmanfm pavucontrol blueberry insomnia floorp dmenu # GUI
      buildkit docker-compose # Docker
    ] ++ listImport "pkgs" [ "gdlauncher" ];
    file = attrImport "config" [ "discord" "zellij" "wallpaper" "mullvad-browser" ];
  };

  gtk = import ./gtk inputs;
  # wayland.windowManager.hyprland = import ./hyprland inputs;

  programs = attrImport "programs" [ "git" "helix" "kitty" "rofi" "starship" "zellij" "zsh" ];
  services = attrImport "services" [ "mako" "gammastep" "syncthing" ];

  sops = import ./keys;

  xdg.userDirs.enable = true;
  xdg.desktopEntries = let
    chromium-flags = if wayland then "--enable-features=UseOzonePlatform --ozone-platform=wayland" else "";
  in {
    i2p-browser = {
      name = "I2P Browser";
      genericName = "Web Browser";
      exec = "${pkgs.mullvad-browser}/bin/mullvad-browser -P i2p";
      categories = [ "Application" "Network" "WebBrowser" ];
    };
    tor-browser = {
      name = "Tor Browser";
      genericName = "Web Browser";
      exec = "${pkgs.mullvad-browser}/bin/mullvad-browser -P tor";
      categories = [ "Application" "Network" "WebBrowser" ];
    };
    discord = {
      name = "Discord";
      genericName = "Chatting";
      exec = "${(pkgs.discord.override { withOpenASAR = true; })}/bin/discord ${chromium-flags}";
      categories = [ "Application" "Network" ];
    };
  };
}
