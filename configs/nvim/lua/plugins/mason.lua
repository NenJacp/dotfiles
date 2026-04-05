return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP Servers
        "svelte-language-server",
        "csharp-language-server",
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "json-lsp",
        "lemminx",
        "lua-language-server",
        "marksman",
      },
    },
  },
}
