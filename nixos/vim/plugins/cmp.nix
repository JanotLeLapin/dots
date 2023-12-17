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
  };
  sources = [
    { name = "nvim_lsp"; }
    { name = "luasnip"; }
    { name = "buffer"; }
  ];
}
