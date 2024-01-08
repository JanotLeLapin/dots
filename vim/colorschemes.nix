{
  tokyonight = {
    enable = false;
    style = "night";
  };
  ayu = {
    enable = false;
    mirage = true;
  };
  catppuccin = {
    enable = true;
    disableBold = true;
    flavour = "macchiato";
    background.dark = "macchiato";
    styles = {
      keywords = ["italic"];
      strings = ["italic"];
    };
    integrations = {
      barbar = true;
      cmp = true;
      treesitter = true;

      telescope.enabled = true;
    };
  };
}
