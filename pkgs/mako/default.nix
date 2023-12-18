{ specialArgs, ... }:

{
  enable = true;
  font = "Victor Mono 12";
  textColor = specialArgs.fg._2;
  backgroundColor = specialArgs.bg._1;
  borderColor = specialArgs.main._0;
  borderRadius = 0;
  borderSize = 2;
  icons = false;
  padding = "10";
  margin = "6";
}
