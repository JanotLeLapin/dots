{ pkgs, args, ... }: {
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
    helix feh acpi brightnessctl
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto
      (pkgs.stdenv.mkDerivation {
        name = "nerd-victor-mono";
        src = pkgs.victor-mono;
        nativeBuildInputs = with pkgs; [ nerd-font-patcher ];
        buildPhase = ''
          find -name \*.ttf -o -name \*.otf -exec nerd-font-patcher --complete {} \;
        '';
        installPhase = "cp -a . $out";
      })
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Roboto" ];
        monospace = [ "Victor Mono" ];
      };
    };
  };

  programs.ssh.startAgent = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  services.geoclue2.enable = true;

  system.stateVersion = args.stateVersion;
}
