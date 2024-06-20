{ pkgs, ... } @ inputs: let
  listImport = path: modules: (map (module: import (./. + "/${path}/${module}") inputs) modules);
  attrImport = path: modules: pkgs.lib.genAttrs modules (module: import (./. + "/${path}/${module}") inputs);
in {
  home = {
    username = "josephd";
    homeDirectory = "/home/josephd";
    stateVersion = "23.05";
    packages = with pkgs; [
      nitch lsd mpc-cli # CLI tools
      pcmanfm pavucontrol blueberry nicotine-plus deluge ario insomnia firefox # GUI
      buildkit docker-compose # Docker
      tor-browser
    ] ++ listImport "pkgs" [ "jdtls" "gdlauncher" ];
    file = attrImport "config" [ "discord" "zellij" "wallpaper" ];
  };

  gtk = import ./gtk inputs;
  wayland.windowManager.hyprland = import ./hyprland inputs;

  programs = attrImport "programs" [ "eww" "git" "helix" "kitty" "neovim" "starship" "vscode" "waybar" "wofi" "zellij" "zsh" ];
  services = attrImport "services" [ "mako" "mpd" "mpd-discord-rpc" "gammastep" "syncthing" ];

  sops = import ./keys;

  xdg.userDirs.enable = true;
  xdg.desktopEntries = let
    chromium-flags = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
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
      exec = "${(pkgs.discord.override { withOpenASAR = false; })}/bin/discord ${chromium-flags}";
      categories = [ "Application" "Network" ];
    };
  };
}
