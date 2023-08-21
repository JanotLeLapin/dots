{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "Victor Mono";
      size = 14;
    };
    theme = "Dark One Nuanced";
    shellIntegration.enableZshIntegration = true;
    settings = {
      symbol_map = "U+f101-U+f208 nonicons";
      disable_ligatures = "never";
      window_padding_width = 0;
      enable_audio_bell = "no";
      confirm_os_window_close = 0;
    };
  };
}
