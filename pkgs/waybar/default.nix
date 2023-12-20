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

      modules-left = ["tray" "river/window" "custom/right-dark"];
      modules-center = ["custom/left-light" "river/tags" "custom/right-light"];
      modules-right = ["custom/left-dark" "clock"];

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

      "clock" = {
        tooltip = false;
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
