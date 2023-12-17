{ pkgs, nixvim, ... }:
{
  programs.nixvim = {
    enable = true;
    colorschemes = import ./colorschemes.nix;
  };
}
