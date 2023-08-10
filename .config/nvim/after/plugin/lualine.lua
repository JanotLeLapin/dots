local theme_name, _ = require("janotlelapin/colors")()

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = theme_name
  }
}
