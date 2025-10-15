local command = vim.api.nvim_create_user_command

command("ToggleFormatting", function()
  vim.g.enable_autoformat = not vim.g.enable_autoformat
end, {
  desc = "Toggle formatting",
})

command("ToggleWreppedLinesHandling", function()
  vim.g.wrapped_lines_hjkl = true
end, {
  desc = "Toggle if j/k should behave like prefixed with g",
})
