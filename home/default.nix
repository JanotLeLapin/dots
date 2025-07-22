{ pkgs, ... } @ inputs: let
  listImport = path: modules: (map (module: import (./. + "/${path}/${module}.nix") inputs) modules);
  attrImport = path: modules: pkgs.lib.genAttrs modules (module: import (./. + "/${path}/${module}.nix") inputs);
in {
  home = {
    username = "josephd";
    homeDirectory = "/home/josephd";
    stateVersion = "25.05";
    packages = with pkgs; [
      nitch # cli
      st pcmanfm pavucontrol blueberry floorp dmenu # gui
      maim xclip # screenshot
    ];
  };

  programs = attrImport "programs" [ "zsh" ];

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = let
      modifier = "Mod4";
    in {
      inherit modifier;
      gaps = {
        inner = 10;
        outer = 5;
      };
      keybindings = pkgs.lib.mkOptionDefault {
        "${modifier}+Return" = "exec st";
        "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
      };
    };
  };

  gtk = import ./gtk.nix inputs;
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };
}
