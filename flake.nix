{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    	inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:mattwparas/helix/steel-event-system";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, sops-nix, helix, ... } @ inputs: let
    eachSystem = fn: nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ] (system: (fn {
      inherit system;
      pkgs = (import nixpkgs { inherit system; });
    }));
    hardware = builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; };
    wayland = true;
  in {
    templates = import ./templates;
    devShells = eachSystem ({ pkgs, ... }: { default = pkgs.callPackage ./shell.nix {}; });
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs wayland; };
      modules = [
        "${hardware}/msi/b550-a-pro"
        ./configuration.nix
        ./gpu/nvidia.nix
        home-manager.nixosModules.home-manager {
          home-manager.sharedModules = [
            sops-nix.homeManagerModules.sops
          ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit wayland helix;
            theme = import ./theme.nix inputs;
            monitors = [
              { name = "DP-1"; mode = "3440x1440"; pos = "0,0"; }
              { name = "HDMI-A-1"; mode = "1920x1080"; pos = "3440,360"; }
            ];
          };
          home-manager.users.josephd = import ./home;
        }
      ];
    };
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs wayland; };
      modules = [
        "${hardware}/asus/fx506hm"
        ./configuration.nix
        ({ pkgs, ... }: {
          hardware.asus.battery = {
            chargeUpto = 85;
            enableChargeUptoScript = true;
          };

          boot.kernelModules = [ "i2c-dev" ];
          hardware.i2c.enable = true;
          services.udev.packages = [ pkgs.openrgb ];
          services.hardware.openrgb.enable = true;
        })
        home-manager.nixosModules.home-manager {
          home-manager.sharedModules = [
            sops-nix.homeManagerModules.sops
          ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit wayland helix;
            theme = import ./theme.nix inputs;
            monitors = [ { name = "eDP-1"; mode = "1920x1080"; pos = "0,0"; } ];
          };
          home-manager.users.josephd = import ./home;
        }
      ];
    };
  };
}
