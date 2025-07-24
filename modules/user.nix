{ pkgs, args, ... }: {
  users.users."${args.user.name}" = {
    isNormalUser = true;
    description = args.user.full;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ git ];
    shell = pkgs.zsh;
  };
}
