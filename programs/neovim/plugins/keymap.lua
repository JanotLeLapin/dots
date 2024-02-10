vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files)
vim.keymap.set('n', '<c-f>', function () require('telescope.builtin').grep_string({ search = vim.fn.input('Search: ') }) end)

vim.keymap.set('n', '<c-left>', ':BufferPrev<cr>')
vim.keymap.set('n', '<c-right>', ':BufferNext<cr>')
vim.keymap.set('n', '<c-q>', ':BufferClose<cr>')
