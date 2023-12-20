{ pkgs, ... }:

let
  theme = pkgs.fetchFromGitHub {
    owner = "Dyzean";
    repo = "Tokyo-Night";
    rev = "a3afefef90d6784645cd129bbd16a24593e4ad53";
    hash = "sha256-lsKkx3DP/W0FW+NbUYysTst69UG4hfryg181TmURMW0=";
  };
in
{
  target = ".config/discord/settings.json";
  text = builtins.toJSON {
    SKIP_HOST_UPDATE = true;
    DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;
    openasar = {
      setup = true;
      cmdPreset = "battery";
      css = builtins.readFile "${theme}/themes/tokyo-night.theme.css";
    };
  };
}
