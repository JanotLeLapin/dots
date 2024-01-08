{ specialArgs, ... }: {
  enable = true;
  settings = {
    normal_window = true;
    prompt = "Wofi";
    width = 350;
    height = 500;
    hide_scroll = true;
    no_actions = true;
    allow_images = false;
  };
  style = specialArgs.format "#" ./style.css;
}
