return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        csharp_ls = {},
        ts_ls = {}, -- Antes era tsserver, ahora es ts_ls
        svelte = {},
        html = {},
        cssls = {},
        tailwindcss = {},
        jsonls = {},
        lemminx = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        marksman = {},
      },
    },
  },
}
