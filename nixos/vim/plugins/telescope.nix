{
  enable = true;
  extraOptions = {
    pickers = {
      find_files = {
        find_command = [ "rg" "--files" "--hidden" "-g" "!.git" ];
      };
    };
  };
  keymaps = { "<C-f>" = "find_files"; };
}
