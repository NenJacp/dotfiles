return {
  {
    "Exafunction/windsurf.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({  -- ✅ Usa "codeium", no "windsurf"
        virtual_text = {
          enabled = true,
          key_bindings = {
            accept = "<C-a>",
            next = "<M-]>",
            prev = "<M-[>",
          }
        }
      })
    end,
    event = "InsertEnter",
  },
}
