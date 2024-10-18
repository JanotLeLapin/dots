{ specialArgs, ... }: {
  enable = true;
  font = "Victor Mono 12";
  textColor = "#" + specialArgs.theme.colors.fg-2;
  backgroundColor = "#" + specialArgs.theme.colors.bg-1;
  borderColor = "#" + specialArgs.theme.colors.main-0;
  borderRadius = 0;
  borderSize = 2;
  icons = false;
  padding = "10";
  margin = "6";
}
