function(fallback)
  local ls = require("luasnip")

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  if cmp.visible() then
    cmp.select_next_item()
  elseif ls.expand_or_jumpable() then
    ls.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end
