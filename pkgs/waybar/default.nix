{ specialArgs, ... }:

let
  tags = n: if n == 0 then 1 else 2 * tags (n - 1);
in
{
  enable = true;
  settings = {
    main = {
      layer = "top";
      position = "top";
      height = 24;

      modules-left = ["tray" "river/window" "custom/right-dark" "custom/right-light"];
      modules-center = ["custom/left-light" "river/tags" "custom/right-light"];
      modules-right = ["custom/left-light" "network" "battery" "custom/left-dark" "clock"];

      "tray" = {
        icon-size = 16;
        spacing = 4;
      };

      "river/window" = {
        format = "{}";
        max-length = 40;
      };

      "river/tags" = {
        num-tags = 5;
        set-tags = map tags [0 1 2 3 4];
      };

      "network" = {
        format-wifi = "{essid}  ";
        format-ethernet = "Ethernet  ";
      };

      "battery" = {
        format = "{capacity}% {icon}";
        # format-icons = ["󰁺 " "󰁻 " "󰁼 " "󰁽 " "󰁾 " "󰁿 " "󰂀 " "󰂁 " "󰂂 " "󰁹 "];
        format-icons = [" " " " " " " " " "];
      };

      "clock" = {
        tooltip = false;
        format = "{:%H:%M}  ";
      };

      "custom/left-dark" = {
        format = "";
        tooltip = false;
      };
      "custom/left-light" = {
        format = "";
        tooltip = false;
      };
      "custom/right-dark" = {
        format = "";
        tooltip = false;
      };
      "custom/right-light" = {
        format = "";
        tooltip = false;
      };
    };
  };
  style = specialArgs.format "#" ./style.css;
}
