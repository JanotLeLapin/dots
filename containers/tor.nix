{
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
          addr = "127.0.0.1";
          port = 9050;
        };
      };
    };
    networking.firewall.allowedTCPPorts = [ 9050 ];
    system.stateVersion = "23.05";
  };
}
