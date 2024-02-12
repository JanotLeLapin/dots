{ config, ... }: {
  enable = true;
  settings = {
    global = {
      username = "31raeftls6no64md4eyuafy7cex4";
      password_cmd = "cat $XDG_RUNTIME_DIR/secrets/password/spotify";
      device_name = "nix";
    };
  };
}
