local ls = require("luasnip")

--[[
vim.cmd[[
" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'

imap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
smap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
]]

ls.config.set_config {
  enable_autosnippets = true,
  store_selection_keys = "<Tab>"
}

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/luasnip" })

-- Keymaps
local ls = require("luasnip")

vim.keymap.set("i", "<Tab>", function() return ls.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>" end, {silent = true, expr = true})
vim.keymap.set("s", "<Tab>", function() return ls.jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>" end, {silent = true, expr = true})

vim.keymap.set({"i", "s"}, "<S-Tab>", function() return ls.jumpable(-1) and "<Plug>luasnip-jump-prev" or "<S-Tab>" end, {silent = true, expr = true})
vim.keymap.set({"i", "s"}, "<C-F>", function() return ls.choice_active() and "<Plug>luasnip-next-choice" or "<C-f>" end, {silent = true, expr = true})

