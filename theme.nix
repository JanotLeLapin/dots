{ nixpkgs, ... }:

rec {
  colors = {
    main-0 = "4f46e5";
    main-1 = "9333ea";
    main-2 = "db2777";

    bg-0 = "0c0a09";
    bg-1 = "1c1917";
    bg-2 = "292524";

    fg-0 = "fafaf9";
    fg-1 = "e7e5e4";
    fg-2 = "a8a29e";
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
