{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "janotlelapin";
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    helix feh acpi xorg.xbacklight
    (dwmblocks.override {
      conf = ./dwmblocks.h;
    })
  ];

  programs.ssh.startAgent = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  services.geoclue2.enable = true;

  system.stateVersion = "25.05";
}
