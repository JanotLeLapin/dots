{ args, ... }: {
  enable = true;
  musicDirectory = "/home/${args.user.name}/music";
}
