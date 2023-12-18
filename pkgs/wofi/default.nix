{
  enable = true;
  settings = {
    normal_window = true;
    prompt = "Hello, World!";
    width = 350;
    height = 700;
    hide_scroll = true;
    no_actions = true;
    allow_images = true;
  };
  style = (builtins.readFile ./style.css);
}
