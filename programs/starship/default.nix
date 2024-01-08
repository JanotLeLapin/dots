_: let
  prompt = success: "[](bold ${if success then "green" else "red"})";
in {
  enable = true;
  enableZshIntegration = true;
  settings = {
    git_branch.symbol = "󰘬 ";
    character = {
      success_symbol = prompt true;
      error_symbol = prompt false;
    };
  };
}
