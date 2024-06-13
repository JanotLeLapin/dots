{ pkgs, specialArgs, ... }: {
  enable = true;
  configDir = pkgs.stdenv.mkDerivation {
    name = "eww-config";
    src = ./.;

    installPhase = ''
      mkdir $out
      echo "${specialArgs.theme.format "#" ./eww.scss}" > $out/eww.scss
      cp ./eww.yuck $out/eww.yuck
    '';
  };
}
