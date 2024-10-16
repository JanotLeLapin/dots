{ pkgs, specialArgs, ... }: {
  enable = true;
  extraConfig = ''
    rivertile -view-padding 6 -outer-padding 6 &
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
      };
    };
    keyboard-layout = "fr";
    default-layout = "rivertile";
  };
}
