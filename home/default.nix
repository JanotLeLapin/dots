{ pkgs, wayland, helix, ... } @ inputs: let
  listImport = path: modules: (map (module: import (./. + "/${path}/${module}") inputs) modules);
  attrImport = path: modules: pkgs.lib.genAttrs modules (module: import (./. + "/${path}/${module}") inputs);
in {
  home = {
    username = "josephd";
    homeDirectory = "/home/josephd";
    stateVersion = "23.05";
    packages = with pkgs; [
      nitch lsd # CLI tools
      maim xclip # Screenshot tools
      pcmanfm pavucontrol blueberry insomnia floorp dmenu # GUI
      buildkit docker-compose # Docker
      (helix.packages."${pkgs.system}".default)
      (st.override {
        conf = builtins.readFile ./st.h;
        extraLibs = with pkgs; [ harfbuzz ];
        patches = [
          (pkgs.fetchurl {
            url = "https://st.suckless.org/patches/ligatures/0.9/st-ligatures-20240105-0.9.diff";
            hash = "sha256-Wcm2RTPlokGFlCsG/GmBEMrwNFpAxgEcqDaTEqKRhL0=";
          })
        ];
      })
      (let
        name = "gdlauncher";
        version = "1.1.30";
        src = pkgs.fetchurl {
          url = "https://github.com/gorilla-devs/GDLauncher/releases/download/${version}/GDLauncher-linux-setup.AppImage";
          hash = "sha256-4cXT3exhoMAK6gW3Cpx1L7cm9Xm0FK912gGcRyLYPwM=";
        };
        appimageContents = pkgs.appimageTools.extractType2 {
          inherit name src;
        };
      in pkgs.appimageTools.wrapType2 {
        inherit name version src;
        extraInstallCommands = ''
          install -m 444 -D ${appimageContents}/${name}.desktop $out/share/applications/${name}.desktop
          install -m 444 -D ${appimageContents}/${name}.png $out/share/icons/hicolor/512x512/apps/${name}.png
          substituteInPlace $out/share/applications/${name}.desktop \
          --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
        '';
      })
    ] ++ (map (game: pkgs.stdenv.mkDerivation {
      name = "game-" + game;
      version = "a78c0b917ffec5fed2f7b64dddceb6d3c57e33d5";
      src = pkgs.fetchzip {
        url = "https://github.com/sponege/terminal-games/archive/a78c0b917ffec5fed2f7b64dddceb6d3c57e33d5.zip";
        hash = "sha256-nWH0u84EZMbHqv1PM1OkjSW0LRzNC5pjaH9K77e2fUM=";
      };

      buildInputs = with pkgs; [ gcc gnumake ncurses ];

      buildPhase = ''
        mkdir -p build
        gcc ${game}/${game}.c -o build/${game} -lncurses -Wno-error=format-security
      '';
      installPhase = ''
        mkdir -p $out/bin
        mv build/${game} $out/bin/game-${game}
      '';
    }) [ "snake" "tetris" ]);
    file = attrImport "config" [ "discord" "helix" "wallpaper" "mullvad-browser" ];
  };

  gtk = import ./gtk.nix inputs;
  # wayland.windowManager.hyprland = import ./hyprland.nix inputs;
  wayland.windowManager.river = import ./river.nix inputs;

  programs = attrImport "programs" [ "git" "starship" "wofi" "zsh" ];
  services = attrImport "services" [ "mako" "gammastep" "syncthing" ];

  sops = import ./keys;
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.services" ];

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
