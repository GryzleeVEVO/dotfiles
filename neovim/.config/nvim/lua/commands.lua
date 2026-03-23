local command = vim.api.nvim_create_user_command

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

command("Tools", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/lua/tools.lua")
end, {
  desc = "Open tools config file",
})
