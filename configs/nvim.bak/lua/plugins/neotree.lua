return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false, -- Aseguramos que se cargue al inicio
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        sources = { "filesystem", "document_symbols" }, -- Quito 'document_symbols' ya que daba problemas
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
         },
        },
        window = {
          width = 30,
          mappings = {
            ["<Right>"] = "open",
            ["l"] = "open",
            ["<Left>"] = "close_node",
            ["h"] = "close_node",
          },
        },
      })

      vim.opt.cursorline = true
      vim.cmd([[ highlight NeoTreeCursorLine guibg=#3c3836 ]])
    end,
  },
}
