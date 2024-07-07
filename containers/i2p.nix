{
  autoStart = true;
  config = { ... }: let address = "127.0.0.1"; in {
    services.i2pd = {
      inherit address;
      enable = true;
      proto = {
        http = {
          inherit address;
          enable = true;
        };
        socksProxy = {
          inherit address;
          enable = true;
        };
        httpProxy = {
          inherit address;
          enable = true;
        };
        sam.enable = true;
      };
    };
    networking.firewall.allowedTCPPorts = [ 4444 4447 7656 7070 ];
    system.stateVersion = "23.05";
  };
}
