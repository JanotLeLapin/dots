{ lib, inputs, config, pkgs, ... }:

let 
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Layan-Dark'
      gsettings set $gnome_schema icon-theme 'Tela-circle-dark'
      gsettings set $gnome_schema font-name 'Roboto'
    '';
  };
  java-language-server = pkgs.writeTextFile {
    name = "java-language-server";
    destination = "/bin/java-language-server";
    executable = true;
    text = let
      jdt_dir = pkgs.jdt-language-server;
      config_dir = "$HOME/.cache/jdtls";
      lombok_dir = pkgs.lombok;
    in ''
      mkdir ${config_dir}
      cp ${jdt_dir}/share/config/config.ini ${config_dir}

      mkdir $HOME/workspace

      java \
      -Declipse.application=org.eclipse.jdt.ls.core.id1 \
      -Dosgi.bundles.defaultStartLevel=4 \
      -Declipse.product=org.eclipse.jdt.ls.core.product \
      -Dlog.protocol=true \
      -Dlog.level=ALL \
      -Xmx4g \
      -javaagent:${lombok_dir}/share/java/lombok.jar \
      --add-modules=ALL-SYSTEM \
      --add-opens java.base/java.util=ALL-UNNAMED \
      --add-opens java.base/java.lang=ALL-UNNAMED \
      -jar ${jdt_dir}/share/java/plugins/org.eclipse.equinox.launcher_*.jar \
      -configuration ${config_dir} \
      -data $HOME/workspace/$1
    '';
  };

in
{
  imports =
    [
      ./home.nix
      ./hardware-configuration.nix
    ] ++ lib.optional (builtins.pathExists ./misc.nix) ./misc.nix;

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

  # hardware.opengl = {
    # enable = true;
    # driSupport = true;
    # driSupport32Bit = true;
  # };

  # Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  services.pipewire = {
    enable = true;
  };

  # X11
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "hyprland";
      gdm = {
        enable = true;
        wayland = true;
      };
    };

    layout = "fr";
    xkbVariant = "";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  hardware.bluetooth.enable = true;

  # Fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      victor-mono
      font-awesome
      (nerdfonts.override { fonts = ["JetBrainsMono"]; })
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Roboto" ];
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
    packages = with pkgs; [
      git nitch home-manager
      pulseaudio-ctl brightnessctl blueberry tor-browser-bundle-bin
      buildkit docker-compose
      opera pavucontrol
      layan-gtk-theme tela-circle-icon-theme configure-gtk
      kitty pcmanfm wofi waybar mako hyprpaper lsd zellij
      java-language-server
      minecraft
      (pkgs.makeDesktopItem {
        name = "discord";
        exec = "${pkgs.discord}/bin/discord --use-gl=desktop";
        desktopName = "Discord";
        icon = "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle/scalable/apps/discord.svg";
      })
    ];
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    bash
    gcc wget unzip glib
    neovim helix ripgrep
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
