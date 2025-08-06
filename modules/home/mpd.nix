{ pkgs, args, ... }: {
  home.packages = with pkgs; [ mpc ];

  services.mpd = {
    enable = true;
    musicDirectory = "/home/${args.user.name}/music";
  };

  systemd.user.services.mpd-events = {
    Unit = {
      Description = "Listens to mpd events to trigger dwmblocks update";
      After = [ "mpd.service" ];
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "mpd-events" ''
        while true; do
          ${pkgs.mpc}/bin/mpc idle player
          ${pkgs.procps}/bin/pkill -RTMIN+10 dwmblocks
        done
      ''}";
      Restart = "always";
      RestartSec = "5";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
