{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Joseph DALY";
    userEmail = "joseph300905@gmail.com";
    extraConfig = {
      init = {
        defaultbranch = "main";
      };
    };

    delta = {
      enable = true;
    };
  };
}
