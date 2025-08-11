{ pkgs, args, ... }: {
  services.xserver.enable = true;
  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.override (old: {
      conf = ./dwm.h;
      patches = [
        ./dwm-gap.diff
      ];
    });
  };
  services.xserver.displayManager.sessionCommands = ''
    dwmblocks &
    feh --bg-scale ${builtins.fetchurl "https://i.redd.it/ofas72yn1kt01.jpg"} &
  '';
  services.displayManager.defaultSession = "none+dwm";
  users.users."${args.user.name}".packages = with pkgs; [
    (dwmblocks.override {
      conf = ./dwmblocks.h;
    })
  ];
}
