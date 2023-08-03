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
      nsp = "nix-shell --run zsh -p";

      # Other
      l = "ls -a";
      c = "clear";
      v = "nvim";
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
