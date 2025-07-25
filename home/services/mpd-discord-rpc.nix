{ ... }: {
  enable = true;
  settings = {
    hosts = [ "localhost:6600" ];
    format = {
      details = "$title";
      state = "On $album by $artist";
      small_image = "";
      small_text = "";
      large_text = "$album";
    };
  };
}
