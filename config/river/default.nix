{ specialArgs, ... }: {
  text = specialArgs.theme.format "0x" ./init.sh;
  target = ".config/river/init";
  executable = true;
}
