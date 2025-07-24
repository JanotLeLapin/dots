{ pkgs, ... }: {
  imports = [
    ./libinput.nix
  ];

  services.xserver.enable = true;
  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.override (old: {
      conf = ./dwm.h;
    });
  };
  services.xserver.displayManager.sessionCommands = ''
    dwmblocks &
    feh --bg-scale ${builtins.fetchurl "https://i.redd.it/ofas72yn1kt01.jpg"} &
  '';
  services.displayManager.defaultSession = "none+dwm";
}
