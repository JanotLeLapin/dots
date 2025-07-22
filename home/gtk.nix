{ pkgs, ... }: {
  enable = true;
  font = {
    name = "Roboto";
  };
  theme = {
    package = pkgs.tokyonight-gtk-theme.override {
      colorVariants = [ "dark" ];
      sizeVariants = [ "standard" ];
      themeVariants = [ "purple" ];
      tweakVariants = [ "black" ];
    };
    name = "Tokyonight-Purple-Dark";
  };
  iconTheme = {
    package = pkgs.tela-circle-icon-theme;
    name = "Tela-circle-dark";
  };
  cursorTheme = {
    package = pkgs.volantes-cursors;
    name = "volantes_cursors";
    size = 16;
  };
}
