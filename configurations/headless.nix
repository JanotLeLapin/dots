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
      ../modules/hardware-configuration.nix
      ../modules/base.nix
      ../modules/locale.nix
      ../modules/mullvad.nix
      ../modules/user.nix
      ../modules/transmission.nix
      ../modules/containers/i2p.nix
      ../modules/containers/tor/relay.nix
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
            ../modules/home/helix.nix
            ../modules/home/starship.nix
            ../modules/home/zsh.nix
          ];
        };
      }
    ];
  }
