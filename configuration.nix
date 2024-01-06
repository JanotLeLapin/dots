{ lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ] ++ lib.optional (builtins.pathExists ./misc.nix) ./misc.nix;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS="1";
  };

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

  # River
  programs.river.enable = true;

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };

  # OpenSSH
  programs.ssh.startAgent = true;

  # X11
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "river";
      sddm.enable = true;
    };

    desktopManager.plasma5.enable = true;

    layout = "fr";
    xkbVariant = "";
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
