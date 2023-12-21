function(fallback)
  local ls = require("luasnip")

  if cmp.visible() then
    cmp.select_prev_item()
  elseif ls.jumpable(-1) then
    ls.jump(-1)
  else
    fallback()
  end
end
