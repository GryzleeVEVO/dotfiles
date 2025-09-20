vim.api.nvim_create_user_command("ToggleFormatting", function()
  vim.g.enable_autoformat = not vim.g.enable_autoformat
end, { desc = "Toggle formatting" })
