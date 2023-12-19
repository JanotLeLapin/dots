{ specialArgs, ... }:

{
  text = specialArgs.format "0x" ./init.sh;
  target = ".config/river/init";
  executable = true;
  onChange = "sh -c $HOME/.config/river/init";
}
