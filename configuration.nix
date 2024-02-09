{ pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 2;
  };

  # Enable networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  networking.firewall.allowedTCPPorts = [ 7656 7070 4447 4444 ];

  services.i2pd = {
    enable = true;
    address = "127.0.0.1";
    bandwidth = 1024;
    proto = {
      http.enable = true;
      socksProxy.enable = true;
      httpProxy.enable = true;
      sam.enable = true;
    };
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };

  # OpenSSH
  programs.ssh.startAgent = true;
  services.gnome.gnome-keyring.enable = true;

  # X11
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "hyprland";
      gdm.enable = true;
    };

    xkb = {
      layout = "fr";
      variant = "";
    };
  };

  xdg.portal = {
    enable = true;
    config.common.default = "wlr";
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
  };

  hardware.bluetooth.enable = true;

  # Fonts
  fonts = let nerd = ((import ./fonts.nix) pkgs) pkgs.victor-mono; in {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      nerd
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Victor Mono" ];
        monospace = [ "Victor Mono" ];
      };
    };
  };

  # Configure console keymap
  console.keyMap = "fr";

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;

  # Define a user account
  programs.zsh.enable = true;
  users.users.josephd = {
    isNormalUser = true;
    description = "Joseph DALY";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    bash gcc wget unzip glib ripgrep sops
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
