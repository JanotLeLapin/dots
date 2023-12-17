{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      # Git
      gst = "git status";
      gd = "git diff";
      glog = "git log";

      ga = "git add";
      gaa = "git add .";
      gcm = "git commit -m";
      gca = "git commit --amend --no-edit";
      gcam = "git commit --amend -m";

      gp = "git push";

      # Nix
      ns = "nix-shell --run zsh";
      nd = "nix develop -c $SHELL";
      nsp = "nix-shell --run zsh -p";

      # Other
      l = "lsd -a";
      c = "clear";
      v = "nvim";
      h = "helix";
    };
    history = {
      size = 1000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      theme = "bira";
    };
  };
}
