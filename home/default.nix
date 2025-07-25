{ pkgs, args, ... } @ inputs: let
  listImport = path: modules: (map (module: import (./. + "/${path}/${module}.nix") inputs) modules);
  attrImport = path: modules: pkgs.lib.genAttrs modules (module: import (./. + "/${path}/${module}.nix") inputs);
  config = source: target: {
    inherit source target;
    recursive = true;
  };
in {
  home = {
    username = args.user.name;
    homeDirectory = "/home/${args.user.name}";
    stateVersion = args.stateVersion;
    packages = with pkgs; [
      nitch mpc # cli
      pcmanfm pavucontrol blueberry floorp dmenu bitwig-studio legcord # gui
      maim xclip # screenshot
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
    ] ++ (map (name: (pkgs.writeScriptBin "${name}-browser" ''
      ${pkgs.mullvad-browser}/bin/mullvad-browser -P ${name}
    '')) [ "i2p" "tor" ]);

    file = {
      mullvad-browser = (config ./config/mullvad-browser ".mullvad/mullvadbrowser");
    };
  };

  programs = attrImport "programs" [ "helix" "keychain" "starship" "zsh" ];
  services = attrImport "services" [ "mpd" "picom" "redshift" "syncthing" ];

  gtk = import ./gtk.nix inputs;
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };
}
