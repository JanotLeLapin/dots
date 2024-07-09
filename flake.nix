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
  };

  outputs = { nixpkgs, home-manager, sops-nix, ... } @ inputs: let
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
            inherit wayland;
            theme = import ./theme.nix inputs;
            monitors = [
              "DP-1,3440x1440,0x0,1"
              "HDMI-1,1920x1080,3440x360,1"
            ];
          };
          home-manager.users.josephd = import ./home.nix;
        }
      ];
    };
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs wayland; };
      modules = [
        "${hardware}/asus/fx506hm"
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.sharedModules = [
            sops-nix.homeManagerModules.sops
          ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit wayland;
            theme = import ./theme.nix inputs;
            monitors = [ "eDP-1,1920x1080,0x0,1" ];
          };
          home-manager.users.josephd = import ./home.nix;
        }
      ];
    };
  };
}
