{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bitwig-cracked = {
      url = "git+https://fem.mint.lgbt/lux/bitwig-cracked-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, home-manager, bitwig-cracked, ... } @ inputs: let
    hardware = builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; };
    overlays = let
      firefox-overlay = name: (self: super: {
        "${name}" = super.writeShellScriptBin "${name}" ''
          export MOZ_USE_XINPUT2=1
          exec ${super."${name}"}/bin/${name} "$@"
        '';
      });
    in [
      (self: super: {
        bitwig-studio = super.writeShellScriptBin "bitwig-studio" ''
          export VK_ICD_FILENAMES=""
          export MESA_VK_DEVICE_SELECT="llvmpipe"
          exec ${bitwig-cracked.packages."x86_64-linux".default}/bin/bitwig-studio "$@"
        '';
      })
      (firefox-overlay "floorp")
      (firefox-overlay "mullvad-browser")
    ];
    user = {
      name = "josephd";
      full = "Joseph DALY";
    };
    homeManagerConfig = paths: { pkgs, ... } @ inputs: let
      evaluated = map (x: import x inputs) paths;
      merged = builtins.foldl' (acc: current:
        inputs.lib.recursiveUpdate acc current
      ) {} evaluated;
    in merged;
  in {
    # e14 gen 5 thinkpad
    nixosConfigurations.e14 = let
      args = {
        inherit user;
        stateVersion = "25.05";
      };
    in nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs args;
      };
      modules = [
        ./modules/hardware-configuration.nix
        ./modules/base.nix
        ./modules/battery.nix
        ./modules/dwm.nix
        ./modules/locale.nix
        ./modules/user.nix
        # ./modules/containers/i2p.nix
        # ./modules/containers/tor/client.nix
        ./modules/gpu/intel.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit args; };
          home-manager.users."${user.name}" = homeManagerConfig [
            ./modules/home/base.nix
            ./modules/home/gtk.nix
            ./modules/home/helix.nix
            ./modules/home/keychain.nix
            ./modules/home/starship.nix
            ./modules/home/zsh.nix

            # ./modules/home/mpd.nix
            # ./modules/home/picom.nix
            ./modules/home/redshift.nix
            # ./modules/home/syncthing.nix
          ];
        }
        "${hardware}/lenovo/thinkpad/e14/intel"
        {
          nixpkgs.overlays = overlays;
          nixpkgs.config.allowUnfree = true;
        }
      ];
    };
  };
}
