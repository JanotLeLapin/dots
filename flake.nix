{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
  };
}
