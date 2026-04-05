-- Load defaults from NvChad
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- QML Language Server setup
vim.lsp.config('qmlls', {
  name = 'qmlls',
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,

  -- QML-specific settings
  cmd = { "qmlls" },
  filetypes = { "qml", "qmljs" },
  root_dir = vim.fn.getcwd(),

  settings = {
    qml = {
      -- Enable all diagnostics
      lint = {
        enabled = true,
      },
      -- Format settings
      format = {
        enabled = true,
      },
    },
  },
})


