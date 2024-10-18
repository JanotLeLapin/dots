{ pkgs, ... }: let
  theme = pkgs.fetchgit {
    url = "https://github.com/refact0r/midnight-discord";
    rev = "6bcea95e1af5ded90eb68cb1b7ef28669da2f6f7";
    sparseCheckout = [
      "flavors"
    ];
    hash = "sha256-wZrOWLV+5j0LaUq6jGpfZyU3rNKBhM6MWDLt+qil7dI=";
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
