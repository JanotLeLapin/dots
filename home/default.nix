{ pkgs, ... } @ inputs: {
  home = {
    username = "josephd";
    homeDirectory = "/home/josephd";
    stateVersion = "25.05";
    packages = with pkgs; [
      nitch lsd # cli
      st pcmanfm pavucontrol blueberry floorp dmenu # gui
      maim xclip # screenshot
    ];
  };

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
}
