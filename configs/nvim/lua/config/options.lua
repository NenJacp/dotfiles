-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Asegurar que el syntax highlighting esté habilitado
vim.opt.syntax = "on" -- Habilita el syntax highlighting nativo como fallback
vim.opt.termguicolors = true -- Necesario para que los colores funcionen correctamente
vim.opt.relativenumber = false

-- Configuración de ortografía (evita los subrayados rojos en español)
vim.opt.spelllang = { "en", "es" }
vim.opt.spell = true
