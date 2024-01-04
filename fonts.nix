{ nerd-font-patcher, stdenv, ... }:

font: stdenv.mkDerivation {
  name = "nerd-${font.name}";
  src = font;
  nativeBuildInputs = [ nerd-font-patcher ];
  buildPhase = ''
    find -name \*.ttf -o -name \*.otf -exec nerd-font-patcher --complete {} \;
  '';
  installPhase = "cp -a . $out";
}
