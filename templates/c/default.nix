{ gcc
, stdenv
}: stdenv.mkDerivation {
  pname = "c";
  version = "0.1";

  buildInputs = [ gcc ];
  src = ./.;

  buildPhase = ''
    gcc src/main.c -o c
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp c $out/bin
  '';
}
