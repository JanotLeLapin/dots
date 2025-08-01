{ ... }: {
  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    keys = [ "github" ];
  };
}
