{ pkgs, ... }: let
  theme = pkgs.fetchgit {
    url = "https://github.com/refact0r/midnight-discord";
    sparseCheckout = [
      "flavors"
    ];
    hash = "sha256-op58ICy8sXX8lDhXBXtA4nJqbneVQjysonbKKUA2nZM=";
  };
in {
  text = builtins.toJSON {
    SKIP_HOST_UPDATE = true;
    IS_MAXIMIZED = true;
    IS_MINIMIZED = false;
    openasar = {
      setup = true;
      cmdPreset = "battery";
      quickstart = true;
      css = builtins.readFile "${theme}/flavors/midnight-rose-pine.theme.css";
    };
  };
  target = ".config/discord/settings.json";
  executable = true;
}
