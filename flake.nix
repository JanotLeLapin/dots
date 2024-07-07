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
    extra = import ./extra.nix;
  in {
    templates = import ./templates;
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.sharedModules = [
            sops-nix.homeManagerModules.sops
          ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            theme = import ./theme.nix inputs;
            extra = import ./extra.nix;
          };
          home-manager.users.josephd = import ./home.nix;
        }
      ] ++ (
        if extra.gpu == "intel" then [ ./gpu/intel.nix ]
        else if extra.gpu == "nvidia" then [ ./gpu/nvidia.nix ]
        else []
      ) ++ (if extra.laptop then [ ./tlp.nix ] else []);
    };
    devShells = eachSystem ({ pkgs, ... }: { default = pkgs.callPackage ./shell.nix {}; });
  };
}
