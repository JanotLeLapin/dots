{ pkgs, ... }: {
  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.override {
      conf = ./config.h;
      patches = [
        ./patches/remove-dmenu.diff
      ];
    };
  };
}
