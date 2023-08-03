local jdtls = require("jdtls")

local jdt_dir = os.getenv("HOME") .. "/jdtls"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set("n", "<C-o>", jdtls.organize_imports, opts)
end

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx4g",
    "-javaagent:" .. jdt_dir .. "/lombok.jar",
    -- "-Xbootclasspath/a:" .. jdt_dir .. "/lombok.jar",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", jdt_dir .. "/plugins/org.eclipse.equinox.launcher_1.6.500.v20230622-2056.jar",
    "-configuration", jdt_dir .. "/config_linux",
    "-data", jdt_dir .. "/workspace/" .. project_name
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
  settings = {
    java = {
      completion = {
        favoriteStaticMembers = {
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*",
        }
      }
    },
  },
  init_options = {
    bundles = {},
  },

  capabilities = capabilities,
  on_attach = on_attach,
}

jdtls.start_or_attach(config)
