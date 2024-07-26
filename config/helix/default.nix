{ pkgs, ... }: {
  source = ./.;
  recursive = true;
  target = ".config/helix";
}
