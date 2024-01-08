{ specialArgs, ... }:

{
  enable = true;
  settings = {
    main = {
      layer = "top";
      position = "top";
      height = 24;

      modules-left = ["tray" "custom/right-dark" "hyprland/window" "custom/right-light"];
      modules-center = ["custom/left-light" "hyprland/workspaces" "custom/right-light"];
      modules-right = ["custom/left-light" "network" "battery" "custom/left-dark" "clock"];

      "tray" = {
        icon-size = 16;
        spacing = 4;
      };

      "hyprland/window" = {
        format = "{}";
      };

      "hyprland/workspaces" = {};

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
