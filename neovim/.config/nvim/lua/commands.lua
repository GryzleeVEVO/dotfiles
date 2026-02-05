local command = vim.api.nvim_create_user_command

command("EnableFormatting", function()
  vim.g.enable_autoformat = true
end, {
  desc = "Enable formatting",
})

command("DisableFormatting", function()
  vim.g.enable_autoformat = false
end, {
  desc = "Disable formatting",
})

command("ToggleFormatting", function()
  vim.g.enable_autoformat = not vim.g.enable_autoformat
end, {
  desc = "Toggle formatting",
})

command("ToggleWrappedLinesHandling", function()
  vim.g.wrapped_lines_jk = not vim.g.wrapped_lines_jk
end, {
  desc = "Toggle if j/k should go up/down the displayed (wrapped) line or the actual line",
})
