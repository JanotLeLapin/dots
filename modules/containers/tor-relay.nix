{ args, ... }: {
  containers.tor = {
    autoStart = true;
    config = { ... }: {
      services.tor = {
        enable = true;
        settings = {
          ORPort = 9001;
          DirPort = 9030;
          SocksPolicy = [ "accept *:*" ];
          BandWidthRate = "100 MBytes";
          RelayBandwidthRate = "15 MBytes";
          RelayBandwidthBurst = "30 MBytes";
          Nickname = "NotchkaLeChat";
          ContactInfo = "joseph300905@gmail.com";
        };
        client = {
          enable = true;
          socksListenAddress = {
            addr = "0.0.0.0";
            port = 9050;
          };
        };
        relay = {
          enable = true;
          role = "relay";
        };
      };
      networking.firewall.allowedTCPPorts = [ 9001 9030 9050 ];
      system.stateVersion = args.stateVersion;
    };
  };
}
