return {
  {
    "folke/todo-comments.nvim",
    event = "VimEnter", -- Mantenemos el evento para que se cargue al inicio
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- Usar la configuración por defecto del plugin
      -- No es necesario poner nada aquí si solo quieres los defaults
    }
  }
}