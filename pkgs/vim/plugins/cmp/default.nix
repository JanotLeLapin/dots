{
  enable = true;
  snippet.expand = "luasnip";
  window = {
    completion = {
      colOffset = -3;
      sidePadding = 1;
    };
  };
  mapping = {
    "<C-x>" = "cmp.mapping.complete()";
    "<CR>" = "cmp.mapping.confirm({ select = true })";
    "<Tab>" = builtins.readFile ./next.lua;
    "<S-Tab>" = builtins.readFile ./prev.lua;
  };
  sources = [
    { name = "nvim_lsp"; }
    { name = "luasnip"; }
    { name = "buffer"; }
  ];
}
