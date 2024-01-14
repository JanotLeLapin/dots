{ rustPlatform
}: rustPlatform.buildRustPackage {
  pname = "project";
  version = "0.1.0";
  src = ./.;
  cargoLock = { lockFile = ./Cargo.lock; };
  nativeBuildInputs = [];
  buildInputs = [];
}
