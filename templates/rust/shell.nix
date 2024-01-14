{ rust-bin
, mkShell
}: mkShell {
  packages = [
    (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
  ];
}
