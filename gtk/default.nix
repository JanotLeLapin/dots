{ pkgs, ... }: {
  enable = true;
  theme = {
    package = pkgs.tokyo-night-gtk;
    name = "Tokyonight-Dark-BL";
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
