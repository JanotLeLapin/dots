{ pkgs, ... }:
{
  text = builtins.toJSON {
    SKIP_HOST_UPDATE = true;
    IS_MAXIMIZED = true;
    IS_MINIMIZED = false;
    openasar = {
      setup = true;
      cmdPreset = "battery";
      quickstart = true;
    };
  };
  target = ".config/discord/settings.json";
  executable = true;
}
