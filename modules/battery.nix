{ ... }: {
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  services.thermald.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
        enable_thresholds = true;
        start_threshold = 0;
        stop_threshold = 80;
      };
    };
  };
}
