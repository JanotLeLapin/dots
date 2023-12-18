{ pkgs, ... }:

pkgs.makeDesktopItem {
  name = "discord";
  exec = "${pkgs.discord}/bin/discord --use-gl=desktop";
  desktopName = "Discord";
  icon = "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle/scalable/apps/discord.svg";
}
