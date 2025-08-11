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
    rimworld-cracked = {
      url = "git+https://codeberg.org/JanotLeLapin/rimworld-cracked-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    polymc = {
      url = "github:PolyMC/PolyMC";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, home-manager, sops-nix, rimworld-cracked, polymc, ... } @ inputs: let
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
        rimworld = rimworld-cracked.packages."x86_64-linux".default.overrideAttrs(oldAttrs: {
          mods = with rimworld-cracked.packages."x86_64-linux"; [
            mod-harmony
            (super.fetchzip {
              url = "https://www.mediafire.com/file_premium/keo25uc375lpn6n/2890920739.zip";
              hash = "sha256-xoYHEqSQv6ZQUSaTYfMeDCCpeu0y5TFC5CIcM15ZAVM=";
            })
          ];
        });
      })
      polymc.overlay
      (firefox-overlay "floorp")
      (firefox-overlay "firefox")
      (firefox-overlay "mullvad-browser")
    ];
    user = {
      name = "josephd";
      full = "Joseph DALY";
    };
  in {
    nixosConfigurations.e14 = import ./configurations/e14.nix inputs { inherit hardware overlays user; };
    nixosConfigurations.headless = import ./configurations/headless.nix inputs { inherit hardware overlays user; };
  };
}
