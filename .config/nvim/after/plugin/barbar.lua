local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-Left>", ":BufferPrev<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":BufferNext<CR>", opts)
vim.keymap.set("n", "<C-Q>", ":BufferClose<CR>", opts)
