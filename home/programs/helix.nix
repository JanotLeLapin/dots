{ pkgs, ... }: {
  enable = true;
  defaultEditor = true;
  extraPackages = with pkgs; [ nil ];
  ignores = [
    "target/"
    "dist/"
    "build/"
    "node_modules/"
    "!.env"
    "!.gitignore"
  ];
  settings = {
    theme = "onedark";
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
  themes = {
    onedark = let
      transparent = "none";
      yellow = "#efbd5d";
      blue = "#41a7fc";
      red = "#f65866";
      purple = "#c75ae8";
      green = "#8bcd5b";
      gold = "#dd9046";
      cyan = "#34bfd0";
      white = "#93a4c3";
      black = "#0c0e15";
      light-black = "#1a212e";
      gray = "#21283b";
      faint-gray = "#283347";
      light-gray = "#2a324a";
      linenr = "#4B5263";
    in {
      "tag" = { fg = red; };
      "attribute" = { fg = yellow; };
      "comment" = { fg = light-gray; modifiers = ["italic"]; };
      "constant" = { fg = cyan; };
      "constant.numeric" = { fg = gold; };
      "constant.builtin" = { fg = gold; };
      "constant.character.escape" = { fg = gold; };
      "constructor" = { fg = blue; };
      "function" = { fg = blue; modifiers = ["italic"]; };
      "function.builtin" = { fg = blue; modifiers = ["italic"]; };
      "function.macro" = { fg = purple; modifiers = ["italic"]; };
      "keyword" = { fg = red; modifiers = ["italic"]; };
      "keyword.control" = { fg = purple; modifiers = ["italic"]; };
      "keyword.control.import" = { fg = red; modifiers = ["italic"]; };
      "keyword.directive" = { fg = purple; modifiers = ["italic"]; };
      "keyword.storage" = { fg = purple; modifiers = ["italic"]; };
      "keyword.operator" = { fg = purple; modifiers = ["italic"]; };
      "label" = { fg = purple; modifiers = ["italic"]; };
      "namespace" = { fg = blue; };
      "operator" = { fg = purple; };
      "special" = { fg = blue; };
      "string" = { fg = green; };
      "type" = { fg = yellow; };
      "variable" = { fg = blue; };
      "variable.builtin" = { fg = blue; };
      "variable.parameter" = { fg = red; };
      "variable.other.member" = { fg = red; };

      "markup.heading" = { fg = red; };
      "markup.raw.inline" = { fg = green; };
      "markup.bold" = { fg = gold; modifiers = ["bold"]; };
      "markup.italic" = { fg = purple; modifiers = ["italic"]; };
      "markup.strikethrough" = { modifiers = ["crossed_out"]; };
      "markup.list" = { fg = red; };
      "markup.quote" = { fg = yellow; };
      "markup.link.url" = { fg = cyan; modifiers = ["underlined"]; };
      "markup.link.text" = { fg = purple; };

      "diff.plus" = green;
      "diff.delta" = gold;
      "diff.minus" = red;

      "diagnostic.info".underline = { color = blue; style = "curl"; };
      "diagnostic.hint".underline = { color = green; style = "curl"; };
      "diagnostic.warning".underline = { color = yellow; style = "curl"; };
      "diagnostic.error".underline = { color = red; style = "curl"; };
      "diagnostic.unnecessary" = { modifiers = ["dim"]; };
      "diagnostic.deprecated" = { modifiers = ["crossed_out"]; };
      "info" = { fg = blue; modifiers = ["bold"]; };
      "hint" = { fg = green; modifiers = ["bold"]; };
      "warning" = { fg = yellow; modifiers = ["bold"]; };
      "error" = { fg = red; modifiers = ["bold"]; };

      "ui.background" = { bg = black; };
      "ui.virtual" = { fg = faint-gray; };
      "ui.virtual.indent-guide" = { fg = faint-gray; };
      "ui.virtual.whitespace" = { fg = light-gray; };
      "ui.virtual.ruler" = { bg = gray; };
      "ui.virtual.inlay-hint" = { fg = light-gray; };
      "ui.virtual.jump-label" = { fg = light-gray; modifiers = ["bold"]; };

      "ui.cursor" = { fg = white; modifiers = ["reversed"]; };
      "ui.cursor.primary" = { fg = white; modifiers = ["reversed"]; };
      "ui.cursor.match" = { fg = blue; modifiers = ["underlined"]; };

      "ui.selection" = { bg = faint-gray; };
      "ui.selection.primary" = { bg = gray; };
      "ui.cursorline.primary" = { bg = light-black; };

      "ui.highlight" = { bg = gray; };
      "ui.highlight.frameline" = { bg = "#97202a"; };

      "ui.linenr" = { fg = linenr; };
      "ui.linenr.selected" = { fg = white; };

      "ui.statusline" = { fg = white; bg = light-black; };
      "ui.statusline.inactive" = { fg = light-gray; bg = light-black; };
      "ui.statusline.normal" = { fg = light-black; bg = blue; modifiers = ["bold"]; };
      "ui.statusline.insert" = { fg = light-black; bg = green; modifiers = ["bold"]; };
      "ui.statusline.select" = { fg = light-black; bg = purple; modifiers = ["bold"]; };

      "ui.bufferline" = { fg = light-gray; bg = light-black; };
      "ui.bufferline.active" = { fg = light-black; bg = blue; underline = { color = light-black; style = "line"; }; };
      "ui.bufferline.background" = { bg = light-black; };

      "ui.text" = { fg = white; };
      "ui.text.directory" = { fg = blue; };
      "ui.text.focus" = { fg = white; bg = light-black; modifiers = ["bold"]; };

      "ui.help" = { fg = white; bg = gray; };
      "ui.popup" = { bg = gray; };
      "ui.window" = { fg = gray; };
      "ui.menu" = transparent;
      "ui.menu.selected" = { fg = black; bg = blue; };
      "ui.menu.scroll" = { fg = white; bg = light-gray; };

      "ui.debug" = { fg = red; };
    };
  };
}
