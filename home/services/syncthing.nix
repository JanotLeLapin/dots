{ args, ... }: {
  enable = true;
  settings = {
    gui.theme = "black";
    devices = {
      "desktop" = {
        name = "desktop";
        id = (builtins.getEnv "SYNCTHING_ID");
        autoAcceptFolders = true;
      };
    };
    folders = {
      "/home/${args.user.name}/music" = {
        id = "music";
        label = "music";
        devices = [ "desktop" ];
        type = "receiveonly";
      };
    };
  };
}
