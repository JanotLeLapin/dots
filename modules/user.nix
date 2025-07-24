{ pkgs, ... }: {
  users.users.josephd = {
    isNormalUser = true;
    description = "Joseph DALY";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ git ];
    shell = pkgs.zsh;
  };
}
