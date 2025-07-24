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
    overlays = [
      (self: super: {
        bitwig-studio = super.writeShellScriptBin "bitwig-studio" ''
          export VK_ICD_FILENAMES=""
          export MESA_VK_DEVICE_SELECT="llvmpipe"
          exec ${bitwig-cracked.packages."x86_64-linux".default}/bin/bitwig-studio "$@"
        '';
      })
      (self: super: {
        floorp = super.writeShellScriptBin "floorp" ''
          export MOZ_USE_XINPUT2=1
          exec ${super.floorp}/bin/floorp "$@"
        '';
      })
    ];
    user = {
      name = "josephd";
      full = "Joseph DALY";
    };
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
        ./modules/fonts.nix
        ./modules/locale.nix
        ./modules/user.nix
        ./modules/gpu/intel.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit args; };
          home-manager.users."${user.name}" = import ./home;
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
