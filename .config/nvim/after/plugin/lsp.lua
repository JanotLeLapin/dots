local cmp = require("cmp")

local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_passing = 0,
    },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-N>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-P>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-x>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.menu = "   (" .. vim_item.kind .. ")"
      vim_item.kind = " " .. cmp_kinds[vim_item.kind] or "" .. " "
      return vim_item
    end
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp = require("lspconfig")
local lsp_defaults = lsp.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  "force",
  lsp_defaults.capabilities,
  capabilities
)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(e)
    local opts = { buffer = e.buf, remap = false }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>d", vim.diagnostic.goto_next, opts)
  end
})

languages = {
  "tsserver", "rust_analyzer", "clangd",
  "astro", "svelte", "tailwindcss",
}
for i, v in ipairs(languages) do
  lsp[v].setup { capabilities = capabilities }
end
lsp.elixirls.setup { capabilities = capabilities, cmd = { "elixir-ls" } }
