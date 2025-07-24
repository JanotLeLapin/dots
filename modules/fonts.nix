{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto
      (pkgs.stdenv.mkDerivation {
        name = "nerd-victor-mono";
        src = pkgs.victor-mono;
        nativeBuildInputs = with pkgs; [ nerd-font-patcher ];
        buildPhase = ''
          find -name \*.ttf -o -name \*.otf -exec nerd-font-patcher --complete {} \;
        '';
        installPhase = "cp -a . $out";
      })
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Roboto" ];
        monospace = [ "Victor Mono" ];
      };
    };
  };
}

