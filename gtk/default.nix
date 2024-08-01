{ pkgs, ... }: {
  enable = true;
  font = {
    name = "Roboto";
  };
  theme = {
    package = pkgs.tokyonight-gtk-theme;
    name = "Tokyonight-Dark";
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
