{ pkgs, ... }: let
  theme = pkgs.fetchurl {
    url = "https://refact0r.github.io/midnight-discord/midnight.css";
    hash = "sha256-QIscjGYKNlCy1SyP+9mH3f8nCKO+Inj3NbT70WaR7SE=";
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
      css = builtins.readFile theme;
    };
  };
  target = ".config/discord/settings.json";
  executable = true;
}
