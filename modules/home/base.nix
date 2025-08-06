{ pkgs, args, ... }: let
  config = source: target: {
    inherit source target;
    recursive = true;
  };
in {
  home = {
    username = args.user.name;
    homeDirectory = "/home/${args.user.name}";
    stateVersion = args.stateVersion;
    packages = with pkgs; [
      nitch # cli
    ];

    file = {
      mullvad-browser = (config ./config/mullvad-browser ".mullvad/mullvadbrowser");
    };
  };
}
