{ pkgs, ... }: {
  enable = true;
  extensions = import ./extensions.nix pkgs.vscode-extensions;
  userSettings = import ./settings.nix;
  keybindings = import ./keymaps.nix;
}
