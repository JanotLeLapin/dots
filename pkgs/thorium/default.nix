{ pkgs, ... }:

let
  name = "thorium";
  version = "117.0.5938.157";
  src = pkgs.fetchurl {
    url = "https://github.com/Alex313031/thorium/releases/download/M${version}/Thorium_Browser_${version}_x64.AppImage";
    hash = "sha256-dlfClBbwSkQg4stKZdSgNg3EFsWksoI21cxRG5SMrOM=";
  };
  appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };
in pkgs.appimageTools.wrapType2 {
  inherit name version src;
  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
    install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
    substituteInPlace $out/share/applications/thorium-browser.desktop \
    --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
  '';
}
