require("telescope").setup {
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "-g", "!.git" }
    }
  }
}

-- Keymaps
vim.keymap.set("n", "<C-f>", require("telescope.builtin").find_files, {})
vim.keymap.set("n", "<C-s>", function ()
  require("telescope.builtin").grep_string({ search = vim.fn.input("Search : ") })
end)
vim.keymap.set("n", "<C-c>", ":TodoTelescope<CR>", {})

