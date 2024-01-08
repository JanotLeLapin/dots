{ specialArgs, ... }:

{
  enable = true;
  font = "Victor Mono 12";
  textColor = "#" + specialArgs.colors.fg-2;
  backgroundColor = "#" + specialArgs.colors.bg-1;
  borderColor = "#" + specialArgs.colors.main-0;
  borderRadius = 0;
  borderSize = 2;
  icons = false;
  padding = "10";
  margin = "6";
}
