{ ... }: {
  services.libinput.enable = true;
  services.libinput.touchpad = {
    naturalScrolling = true;
    disableWhileTyping = true;
    tapping = true;
    accelSpeed = "0.1";
    scrollMethod = "twofinger";
  };
}
