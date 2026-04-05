require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- tree
-- map("n", "<leader>e", ":Neotree focus<CR>", { desc = "Focus Neo-tree" })
-- map("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

-- Snacks Explorer
map("n", "<leader>e", function()
    require("snacks.explorer").open()
end, { desc = "Open Snacks Explorer" })

-- Usar Telescope para símbolos (snacks no tiene equivalente directo)
map("n", "<leader>fs", ":Telescope lsp_document_symbols<cr>", { desc = "Document Symbols (Telescope)" })

-- Snacks.nvim: Búsquedas específicas con grep
map("n", "<leader>fct", function()
    require("snacks.picker").grep({
        search = "TODO|FIXME|BUG",
        args = { "--type", "text" }
    })
end, { desc = "Find TODOs (Snacks)" })

map("n", "<leader>fcw", function()
    require("snacks.picker").grep({
        search = "WARN|WARNING",
        args = { "--type", "text" }
    })
end, { desc = "Find WARNs (Snacks)" })

map("n", "<leader>fcn", function()
    require("snacks.picker").grep({
        search = "NOTE|INFO",
        args = { "--type", "text" }
    })
end, { desc = "Find NOTEs (Snacks)" })

-- Live grep general (sin pre-filtros)
map("n", "<leader>fcl", function()
    require("snacks.picker").grep()
end, { desc = "Live Grep (Snacks)" })

-- Alternativa: usar words para buscar palabra bajo cursor
map("n", "<leader>fw", function()
    require("snacks.picker").grep({
        search = vim.fn.expand("<cword>")
    })
end, { desc = "Find word under cursor (Snacks)" })

-- Snacks.nvim: Equivalentes adicionales a Telescope (desde directorio actual)
map("n", "<leader>ff", function()
    require("snacks.picker").files()
end, { desc = "Find Files (Snacks)" })

map("n", "<leader>fa", function()
    require("snacks.picker").files({
      hidden  = true,    -- mostrar archivos ocultos (.gitignore, .env, etc.)
      ignored = true,    -- incluir archivos ignorados por VCS
      follow  = true,    -- seguir symlinks
      -- exclude = { ".gitignore" },  -- opcional: excluir carpetas concretas como .git (eliminado para mostrar todos los archivos)
    })
end, { desc = "Snacks: find files hidden & ignored" })


map("n", "<leader>fb", function()
    require("snacks.picker").buffers()
end, { desc = "Find Buffers (Snacks)" })

map("n", "<leader>fr", function()
    require("snacks.picker").recent()
end, { desc = "Recent Files (Snacks)" })

-- Snacks.nvim: Rutas específicas para dashboard/config
map("n", "<leader>fp", function()
    require("snacks.picker").files({ cwd = vim.fn.expand("~") })
end, { desc = "Open Project Home (Snacks)" })

map("n", "<leader>fc", function()
    require("snacks.picker").files({ cwd = "C:/Users/Damaya/AppData/Local/nvim", prompt = "Config Files" })
end, { desc = "Open Config (Snacks)" })

-- Lazygit mappings
map("n", "<leader>gl", ":LazyGit<cr>", { desc = "Open LazyGit" })

-- ===== LEADER Q MAPPINGS (QUIT/EXIT) =====
-- Cerrar sesión por completo (doble q)
map("n", "<leader>qq", ":qa!<CR>", { desc = "Quit all (force)" })

-- Cerrar buffer actual
map("n", "<leader>q", ":q<CR>", { desc = "Quit current buffer" })

-- Cerrar buffer actual sin guardar
map("n", "<leader>q!", ":q!<CR>", { desc = "Quit without saving" })

-- Cerrar buffer actual y guardar
map("n", "<leader>qw", ":wq<CR>", { desc = "Save and quit" })

-- Cerrar todos los buffers excepto el actual
map("n", "<leader>qo", ":only<CR>", { desc = "Close other buffers" })

-- Cerrar buffer actual y abrir el siguiente
map("n", "<leader>qn", ":bn<CR>:bd#<CR>", { desc = "Close current, open next" })

-- ===== DOBLE LEADER MAPPINGS (GLOBAL SEARCH) =====

-- Búsqueda global solo en archivos de código
map("n", "<leader><leader>", function()
    require("snacks.picker").files({
        hidden  = true,
        ignored = true,
        follow  = true,
        exclude = { ".gitignore" },
    })
end, { desc = "Snacks: find files hidden & ignored" })
