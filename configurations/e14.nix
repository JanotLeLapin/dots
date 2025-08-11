{ nixpkgs, home-manager, sops-nix, ... } @ inputs:
  { hardware, overlays, user, ... }: let
    args = {
      inherit user;
      stateVersion = "25.05";
    };
  in nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs args;
    };
    modules = [
      { nixpkgs.overlays = overlays; }
      "${hardware}/lenovo/thinkpad/e14/intel"
      ../modules/hardware-configuration.nix
      ../modules/base.nix
      ../modules/battery.nix
      ../modules/dwm
      ../modules/libinput.nix
      ../modules/locale.nix
      ../modules/mullvad.nix
      ../modules/user.nix
      ../modules/gpu/intel.nix
      ../modules/transmission.nix
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit args; };
        home-manager.sharedModules = [
          sops-nix.homeManagerModules.sops
        ];
        home-manager.users."${user.name}" = _: {
          imports = [
            ../modules/home/base.nix
            ../modules/home/gtk.nix
            ../modules/home/gui.nix
            ../modules/home/helix.nix
            ../modules/home/keychain.nix
            ../modules/home/sops.nix
            ../modules/home/starship.nix
            ../modules/home/zsh.nix

            # ../modules/home/mpd.nix
            ../modules/home/picom.nix
            ../modules/home/redshift.nix
            # ../modules/home/syncthing.nix
          ];
        };
      }
    ];
  }
