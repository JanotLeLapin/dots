local theme_name, theme = require("janotlelapin/colors")()

if theme_name == "tokyonight" then
  theme.setup {
    style = "storm"
  }

  vim.cmd[[colorscheme tokyonight]]
elseif theme_name == "onedark" then
  theme.setup {
    style = "cool",
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
elseif theme_name == "catppuccin" then
  theme.setup {
    flavour = "macchiato",
    term_colors = true,
    integrations = {
      barbar = true,
      barbecue = {
        dim_dirname = true,
        bold_basename = true,
      },
      styles = {
        keywords = { "italic" },
      },
      cmp = true,
      telescope = true,
      treesitter = true,
    },
    custom_highlights = function(colors)
      return {
        Pmenu = { bg = colors.crust },
      }
    end,
  }
  vim.cmd[[colorscheme catppuccin]]
end
