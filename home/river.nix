{ pkgs, specialArgs, ... }: {
  enable = true;
  extraConfig = let
    pow = x: y: if y == 0 then 1 else x * pow x (y - 1);
    touchpad = "$(riverctl list-inputs | grep Touchpad)";
    tags = [
      "ampersand"
      "eacute"
      "quotedbl"
      "apostrophe"
      "parenleft"
      "minus"
      "egrave"
      "underscore"
      "ccedilla"
      "agrave"
    ];
    tagMappings = tag: key: ''
      riverctl map normal Super ${key} set-focused-tags ${toString (pow 2 tag)}
      riverctl map normal Super+Shift ${key} set-view-tags ${toString (pow 2 tag)}
    '';
  in ''
    rivertile -view-padding 6 -outer-padding 6 &
    ${toString (map (monitor: "${pkgs.wlr-randr}/bin/wlr-randr --output ${monitor.name} --mode ${monitor.mode} --pos ${monitor.pos} --scale 1\n") specialArgs.monitors)}

    riverctl input ${touchpad} tap enabled
    riverctl input ${touchpad} natural-scroll enabled

    ${pkgs.lib.strings.concatStrings (pkgs.lib.lists.imap1 tagMappings tags)}
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
