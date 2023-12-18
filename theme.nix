{ nixpkgs, ... }:

rec {
  colors = {
    main-0 = "818cf8";
    main-1 = "6366f1";
    main-2 = "4f46e5";

    bg-0 = "020617";
    bg-1 = "0f172a";
    bg-2 = "1e293b";

    fg-0 = "f8fafc";
    fg-1 = "f1f5f9";
    fg-2 = "e2e8f0";
  };

  format = prefix: file: let
    replaceWord = word: if builtins.substring 0 2 word == "__"
      then let
        len = builtins.stringLength word - 1;
        lst = nixpkgs.lib.strings.splitString "__" (builtins.substring 2 len word);
        head = nixpkgs.lib.lists.head lst;
        tail = nixpkgs.lib.strings.tail lst;
      in prefix + colors.${head} + (builtins.concatStringsSep "" tail)
      else word;

    contents = builtins.readFile file;
    words = nixpkgs.lib.strings.splitString " " contents;

    replacedWords = map replaceWord words;
  in builtins.concatStringsSep " " replacedWords;
}
