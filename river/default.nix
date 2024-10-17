{ pkgs, specialArgs, ... }: {
  enable = true;
  extraConfig = let
    touchpad = "$(riverctl list-inputs | grep Touchpad)";
  in ''
    rivertile -view-padding 6 -outer-padding 6 &
    ${toString (map (monitor: "${pkgs.wlr-randr}/bin/wlr-randr --output ${monitor.name} --mode ${monitor.mode} --pos ${monitor.pos} --scale 1\n") specialArgs.monitors)}

    riverctl input ${touchpad} tap enabled
    riverctl input ${touchpad} natural-scroll enabled
  '';
  settings = {
    border-width = 2;
    map = {
      normal = {
        "Super Q" = "close";
        "Super Return" = "spawn st";
        "Super+Shift E" = "exit";

        "Super J" = "focus-view next";
        "Super K" = "focus-view previous";
        "Super+Shift J" = "swap next";
        "Super+Shift K" = "swap previous";

        "Super H" = "send-layout-cmd rivertile 'main-ratio -0.05'";
        "Super L" = "send-layout-cmd rivertile 'main-ratio +0.05'";

        "Super D" = "spawn 'wofi --show drun'";
      };
    };
    keyboard-layout = "fr";
    default-layout = "rivertile";
  };
}
