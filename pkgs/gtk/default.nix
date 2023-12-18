{ pkgs, ... }:

pkgs.writeTextFile {
  name = "configure-gtk";
  destination = "/bin/configure-gtk";
  executable = true;
  text = let
    schema = pkgs.gsettings-desktop-schemas;
    datadir = "${schema}/share/gsettings-schemas/${schema.name}";
  in ''
    export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
    gnome_schema=org.gnome.desktop.interface
    gsettings set $gnome_schema gtk-theme 'Layan-Dark'
    gsettings set $gnome_schema icon-theme 'Tela-circle-dark'
    gsettings set $gnome_schema font-name 'Roboto'
  '';
}
