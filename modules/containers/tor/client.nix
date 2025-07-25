{ args, ... }: {
  containers.tor = {
    autoStart = true;
    config = { ... }: {
      services.tor = {
        enable = true;
        settings = {
          SocksPolicy = [ "accept *:*" ];
          BandWidthRate = "100 MBytes";
        };
        client = {
          enable = true;
          socksListenAddress = {
            addr = "0.0.0.0";
            port = 9050;
          };
        };
      };
      networking.firewall.allowedTCPPorts = [ 9050 ];
      system.stateVersion = args.stateVersion;
    };
  };
}
