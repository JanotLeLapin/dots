-- Luasnip
vim.keymap.set("i", "<Tab>", function() return ls.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>" end, {silent = true, expr = true})
vim.keymap.set("s", "<Tab>", function() return ls.jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>" end, {silent = true, expr = true})

vim.keymap.set({"i", "s"}, "<S-Tab>", function() return ls.jumpable(-1) and "<Plug>luasnip-jump-prev" or "<S-Tab>" end, {silent = true, expr = true})
vim.keymap.set({"i", "s"}, "<C-F>", function() return ls.choice_active() and "<Plug>luasnip-next-choice" or "<C-f>" end, {silent = true, expr = true})

-- Telescope
vim.keymap.set("n", "<C-f>", require("telescope.builtin").find_files, {})
vim.keymap.set("n", "<C-s>", function ()
  require("telescope.builtin").grep_string({ search = vim.fn.input("Search : ") })
end)
vim.keymap.set("n", "<C-c>", ":TodoTelescope<CR>", {})

-- Barbar
vim.keymap.set("n", "<C-Left>", ":BufferPrev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Right>", ":BufferNext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Q>", ":BufferClose<CR>", { noremap = true, silent = true })
