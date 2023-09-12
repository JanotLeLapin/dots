local ls = require("luasnip")

vim.opt.wrap = true

return {
  -- Greek letters
  s({trig = ",A", snippetType="autosnippet"}, { t("\\Alpha") }),
  s({trig = ",a", snippetType="autosnippet"}, { t("\\alpha") }),
  s({trig = ",B", snippetType="autosnippet"}, { t("\\Beta") }),
  s({trig = ",b", snippetType="autosnippet"}, { t("\\beta") }),
  s({trig = ",G", snippetType="autosnippet"}, { t("\\Gamma") }),
  s({trig = ",g", snippetType="autosnippet"}, { t("\\gamma") }),
  s({trig = ",D", snippetType="autosnippet"}, { t("\\Delta") }),
  s({trig = ",d", snippetType="autosnippet"}, { t("\\delta") }),
  s({trig = ",T", snippetType="autosnippet"}, { t("\\Theta") }),
  s({trig = ",t", snippetType="autosnippet"}, { t("\\theta") }),
  s({trig = ",L", snippetType="autosnippet"}, { t("\\Lambda") }),
  s({trig = ",l", snippetType="autosnippet"}, { t("\\lambda") }),
  s({trig = ",m", snippetType="autosnippet"}, { t("\\mu") }),
  s({trig = ",P", snippetType="autosnippet"}, { t("\\Pi") }),
  s({trig = ",p", snippetType="autosnippet"}, { t("\\pi") }),
  s({trig = ",S", snippetType="autosnippet"}, { t("\\Sigma") }),
  s({trig = ",s", snippetType="autosnippet"}, { t("\\sigma") }),
  s({trig = ",F", snippetType="autosnippet"}, { t("\\Phi") }),
  s({trig = ",f", snippetType="autosnippet"}, { t("\\phi") }),
  s({trig = ",O", snippetType="autosnippet"}, { t("\\Omega") }),
  s({trig = ",o", snippetType="autosnippet"}, { t("\\Omega") }),

  -- Symbols
  s({trig = ",i", snippetType="autosnippet"}, { t("\\infty") }),
  s({trig = ',*', snippetType="autosnippet"}, { t("\\times") }),
  s({trig = ',.', snippetType="autosnippet"}, { t("\\cdot") }),

  -- Positional
  s({trig = "!e", snippetType="autosnippet"}, {
    t("^{"), i(1), t("}"),
  }),
  s({trig = "!s", snippetType="autosnippet"}, {
    t("_{"), i(1), t("}"),
  }),

  -- Operations
  s({trig = "ff", snippetType="autosnippet"}, {
    t("\\frac{"), i(1), t("}{"), i(2), t("}"),
  }),
  s({trig = "ii", snippetType="autosnippet"}, {
    t("\\int_{"), i(1), t("}^{"), i(2), t("}"),
  }),
  s({trig = "ss", snippetType="autosnippet"}, {
    t("\\sum_{"), i(1), t("}^{"), i(2), t("}"),
  }),
  s({trig = "pp", snippetType="autosnippet"}, {
    t("\\prod_{"), i(1), t("}^{"), i(2), t("}"),
  }),

  -- Sets
  s({trig = ";S", snippetType="autosnippet"}, {
    t("\\mathbb{"), i(1), t("}"),
  }),
  s({trig = ";ss", snippetType="autosnippet"}, { t("\\subset") }),
  s({trig = ";in", snippetType="autosnippet"}, { t("\\in") }),

  -- Comparators
  s({trig = "<= ", snippetType="autosnippet"}, { t("\\leqslant ") }),
  s({trig = ">= ", snippetType="autosnippet"}, { t("\\geqslant ") }),
  s({trig = "<=> ", snippetType="autosnippet"}, { t("\\Leftrightarrow ") }),
  s({trig = "!= ", snippetType="autosnippet"}, { t("\\neq ") }),

  -- Misc
  s({trig = ";v", snippetType="autosnippet"}, {
    t("\\overrightarrow{"), i(1), t("}")
  }),
  s({trig = ";d", snippetType="autosnippet"}, {
    t("\\overline{"), i(1), t("}")
  })
}
