{ args, ... }: {
  services.transmission.enable = true;
  users.users."${args.user.name}".extraGroups = [ "transmission" ];
  systemd.tmpfiles.settings = {
    "10-transmission" = {
      "/var/lib/transmission" = {
        d = {
          group = "transmission";
          mode = "0775";
          user = "transmission";
        };
      };
    };
  };
}
