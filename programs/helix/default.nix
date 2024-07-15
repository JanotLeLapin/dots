{ pkgs, ... }: {
  enable = true;
  defaultEditor = true;
  ignores = [
    "build/" "dist/" "target/"
    "node_modules/"
  ];

  settings = {
    theme = "nightfox";
    editor = {
      line-number = "relative";
      mouse = false;

      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      lsp = {
        enable = true;
        display-messages = true;
      };

      whitespace = {
        render = "all";
        characters = {
          space = "·";
          nbsp = "⍽";
          nnbsp = "␣";
          tab = "→";
          newline = "⏎";
          tabpad = "·" ;
        };
      };

      indent-guides.render = true;
    };

    keys = {
      normal = {
        space.q = ":q";
        space.w = ":w";
      };
    };
  };
}
