{ args, ... }: {
  sops = {
    age.keyFile = "/home/${args.user.name}/.age";
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      "ssh/github" = { path = "%r/ssh/github"; };
      "ssh/codeberg" = { path = "%r/ssh/codeberg"; };
    };
  };
}
