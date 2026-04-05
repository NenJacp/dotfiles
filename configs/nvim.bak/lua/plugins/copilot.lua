return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    opts = {
    },
    cmd = "CopilotChat", -- Carga solo al usar el comando
    keys = {
      { "<leader>zc", "<cmd>CopilotChat<cr>", desc = "Abrir Copilot Chat" },
      { "<leader>zC", "<cmd>CopilotChatToggle<cr>", desc = "Activar/Desactivar Copilot Chat" },
      { "<leader>ze", "<cmd>CopilotChatExplain<cr>", desc = "Explicar Copilot Chat" },
      { "<leader>zr", "<cmd>CopilotChatReview<cr>", desc = "Revisar Copilot Chat" },
      { "<leader>zf", "<cmd>CopilotChatFix<cr>", desc = "Corregir Copilot Chat" },
      { "<leader>zo", "<cmd>CopilotChatOptimize<cr>", desc = "Optimizar Copilot Chat" },
      { "<leader>zd", "<cmd>CopilotChatDocs<cr>", desc = "Generar Documentación" },
      { "<leader>zt", "<cmd>CopilotChatTest<cr>", desc = "Generar Pruebas" },
      { "<leader>zm", "<cmd>CopilotChatCommit<cr>", desc = "Generar Commit" },
      { "<leader>zs", "<cmd>CopilotChatCommit<cr>", desc = "Generar Commit en selección" },
    },
  },
}
