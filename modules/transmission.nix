{ args, ... }: {
  services.transmission.enable = true;
  users.users."${args.user.name}".extraGroups = [ "transmission" ];
}
