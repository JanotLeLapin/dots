{ pkgs, ... }:

let
  default = { owner = "josephd"; };
in
{
  sops = {
    defaultSopsFile = ./keys.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = /home/josephd/.config/sops/age/keys.txt;
    secrets = {
      "ssh/github" = default;
      "ssh/codeberg" = default;
    };
  };
}
