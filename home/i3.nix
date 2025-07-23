{ pkgs, ... }: {
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
}
