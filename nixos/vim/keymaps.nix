let
  default = { noremap = true; silent = true; };
  telescope = {
    default = "require('telescope.builtin').find_files";
    search = "function ()
      require('telescope.builtin').grep_string({ search = vim.fn.input('Search: ') })
    end";
  };
in
[
  { mode = "n"; key = "<C-Left>"; action = ":BufferPrev<CR>"; options = default; }
  { mode = "n"; key = "<C-Right>"; action = ":BufferNext<CR>"; options = default; }
  { mode = "n"; key = "<C-Q>"; action = ":BufferClose<CR>"; options = default; }

  { mode = "n"; key = "<C-F>"; action = telescope.default; lua = true; options = default; }
  { mode = "n"; key = "<C-S>"; action = telescope.search; lua = true; options = default; }
]
