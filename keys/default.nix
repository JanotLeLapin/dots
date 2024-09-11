{
  defaultSopsFile = ./keys.yaml;
  defaultSopsFormat = "yaml";
  age.keyFile = /home/josephd/.config/sops/age/keys.txt;
  secrets = {
    "ssh/github" = { path = "%r/ssh/github"; };
    "ssh/atf" = { path = "%r/ssh/atf"; };
    "ssh/sapphire" = { path = "%r/ssh/sapphire"; };
  };
}
