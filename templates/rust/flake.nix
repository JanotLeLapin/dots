{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    nixpkgs,
    overlay,
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
    devShells = eachSystem ({ pkgs, ... }: { default = pkgs.callPackage ./shell.nix {}; });
    packages = eachSystem ({ pkgs, ... }: { default = pkgs.callPackage ./default.nix {}; });
  };
}
