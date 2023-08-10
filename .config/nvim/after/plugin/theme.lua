local theme_name, theme = require("janotlelapin/colors")()

if theme_name == "tokyonight" then
  theme.setup {
    style = "storm"
  }

  vim.cmd[[colorscheme tokyonight]]
elseif theme_name == "onedark" then
  theme.setup {
    style = "deep",
    term_colors = true,
    code_style = {
      comments = 'italic',
      keywords = 'italic',
      functions = 'italic',
    },
    diagnostics = {
      darker = true,
      undercurl = false,
    },
  }
  theme.load()
end
