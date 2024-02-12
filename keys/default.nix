{ pkgs, config, ... }:

let
  default = {
    owner = config.users.users.josephd.name;
    group = config.users.users.josephd.group;
  };
in
{
  sops = {
    defaultSopsFile = ./keys.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = /home/josephd/.config/sops/age/keys.txt;
    secrets = {
      "ssh/github" = default;
      "ssh/codeberg" = default;
      "ssh/atf" = default;
      "password/spotify" = default;
    };
  };
}
