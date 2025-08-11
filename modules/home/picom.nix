{ ... }: {
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    inactiveOpacity = 0.9;
    opacityRules = [
      "80:class_g = 'st-256color'"
      "80:class_g = 'legcord'"
      "100:class_g = 'floorp'"
    ];
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 5;
      };
    };
  };
}
