return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Lenguajes principales
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "fish",
        "zsh",
        -- Web development
        "html",
        "css",
        "javascript",
        "typescript",
        "json",
        "svelte",
        -- Otros lenguajes
        "c",
        "cpp",
        "c_sharp",
        "python",
        "rust",
        "go",
        "java",
        "xml",
        "yaml",
        -- Markdown (INDISPENSABLES para .md)
        "markdown",
        "markdown_inline",
      },
      -- Habilita el highlighting incremental
      highlight = {
        enable = true,
        -- Usa el highlighting nativo como fallback
        additional_vim_regex_highlighting = false,
      },
      -- Habilita el indentado automático
      indent = {
        enable = true,
      },
    },
  },
}
