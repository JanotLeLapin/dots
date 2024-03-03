{ ... }: {
  enable = true;
  settings = {
    id = 677226551607033903;
    hosts = [ "localhost:6600" ];
    format = {
      details = "$title";
      state = "Sur $album, de $artist";
      timestamp = "elapsed";
      large_text = "$album";
    };
  };
}
