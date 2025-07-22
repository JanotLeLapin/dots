{ config, ... }: {
  enable = true;
  enableCompletion = true;
  shellAliases = {
    # git
    gst = "git status";
    gd = "git diff";
    glog = "git log";
    ga = "git add";
    gaa = "git add .";
    gcm = "git commit -m";
    gca = "git commit --amend --no-edit";
    gcam = "git commit --amend -m";
    gr = "git restore";
    gra = "git restore .";
    gp = "git push";

    # nix
    nd = "nix develop -c $SHELL";
    nf = "nix flake";
    ns = "nix shell";
    nr = "sudo nixos-rebuild switch --impure --flake";

    # other
    l = "ls -a";
    c = "clear";
    v = "nvim";
    h = "hx";
  };
  history = {
    size = 1000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
  oh-my-zsh = {
    enable = true;
    theme = "bira";
  };
}
