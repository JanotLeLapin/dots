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
    "<Tab>" = "function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end";
    "<S-Tab>" = "function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end";
  };
  sources = [
    { name = "nvim_lsp"; }
    { name = "luasnip"; }
    { name = "buffer"; }
  ];
}
