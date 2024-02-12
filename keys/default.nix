{
  defaultSopsFile = ./keys.yaml;
  defaultSopsFormat = "yaml";
  age.keyFile = /home/josephd/.config/sops/age/keys.txt;
  secrets = {
    "ssh/github" = { path = "%r/ssh/github"; };
    "ssh/codeberg" = { path = "%r/ssh/codeberg"; };
    "ssh/atf" = { path = "%r/ssh/atf"; };
    "password/spotify" = { path = "%r/password/spotify"; };
  };
}
