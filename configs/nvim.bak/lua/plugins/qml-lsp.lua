-- QML Language Server configuration for NvChad
-- This file should be placed in ~/.config/nvim/lua/plugins/qml-lsp.lua

return {
  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "qmljs",
        "javascript",
        "typescript",
      },
    },
  },
}
