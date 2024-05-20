{ config, ... }: {
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
    gr = "git restore";
    gra = "git restore .";
    gp = "git push";

    # Nix
    nd = "nix develop -c $SHELL";
    nf = "nix flake";
    ns = "nix shell";
    nr = "sudo nixos-rebuild switch --impure --flake";

    # SSH
    ssag = "ssh-add $XDG_RUNTIME_DIR/ssh/github";
    ssac = "ssh-add $XDG_RUNTIME_DIR/ssh/codeberg";
    ssal = "ssh-add $XDG_RUNTIME_DIR/ssh/gitlab";
    ssaa = "ssh-add $XDG_RUNTIME_DIR/ssh/atf";

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
}
