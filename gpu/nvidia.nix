{ config, wayland, ... }: {
  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  environment.sessionVariables = if wayland then {
    WLR_NO_HARDWARE_CURSORS="1";
  } else {};

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
