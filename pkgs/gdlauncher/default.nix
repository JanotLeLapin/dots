{ pkgs, ... }:

let
  name = "gdlauncher";
  version = "1.1.30";
  src = pkgs.fetchurl {
    url = "https://github.com/gorilla-devs/GDLauncher/releases/download/v1.1.30/GDLauncher-linux-setup.AppImage";
    hash = "sha256-4cXT3exhoMAK6gW3Cpx1L7cm9Xm0FK912gGcRyLYPwM=";
  };
  appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };
in pkgs.appimageTools.wrapType2 {
  inherit name version src;
  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${name}.desktop $out/share/applications/${name}.desktop
    install -m 444 -D ${appimageContents}/${name}.png $out/share/icons/hicolor/512x512/apps/${name}.png
    substituteInPlace $out/share/applications/${name}.desktop \
    --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
  '';
}
