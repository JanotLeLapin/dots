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
    ];
  in {
    nixosConfigurations.janotlelapin = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.josephd = import ./home;
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
