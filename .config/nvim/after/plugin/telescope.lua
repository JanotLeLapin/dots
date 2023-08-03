local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-f>", builtin.find_files, {})
vim.keymap.set("n", "<C-s>", function ()
  builtin.grep_string({ search = vim.fn.input("Search : ") })
end)

require("telescope").setup {
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "-g", "!.git" }
    }
  }
}
