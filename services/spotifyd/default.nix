{ config, ... }: {
  enable = true;
  settings = {
    global = {
      username = "31raeftls6no64md4eyuafy7cex4";
      password = builtins.readFile ("/run/user/1000/secrets/password/spotify");
      device_name = "nix";
    };
  };
}
