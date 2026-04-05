return {
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    init = function()
      -- Automatically run :ShowkeysToggle when Neovim starts
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.cmd("ShowkeysToggle")
        end,
      })
    end,
  }
}
