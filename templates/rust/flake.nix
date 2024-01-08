{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    overlay.url = "github:oxalica/rust-overlay";
    crate2nix.url = "github:nix-community/crate2nix";
  };

  outputs = {
    nixpkgs,
    overlay,
    crate2nix,
    ...
  }: let
    eachSystem = fn: nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ] (system: (fn {
      inherit system;
      pkgs = (import nixpkgs { inherit system; overlays = [ (import overlay) ]; } );
    }));
  in {
    devShells = eachSystem ({ pkgs, ... }: {
      default = pkgs.mkShell { packages = [ (pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml) ]; };
    });
    packages = eachSystem ({ pkgs, system }: let
      cargoNix = crate2nix.tools.${system}.appliedCargoNix {
        name = "rust";
        src = ./.;
      };
    in {
      default = cargoNix.rootCrate.build;
    });
  };
}
