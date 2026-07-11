local M = {}

local cmd = vim.api.nvim_create_user_command

cmd("ToggleFormatting", function()
  vim.g.autoformat = not vim.g.autoformat
end, {
  desc = "Toggle automatic formatting",
})

cmd("ToggleUpDownDisplayLines", function()
  vim.g.up_down_display_lines = not vim.g.up_down_display_lines
end, {
  desc = "Toggle whether j/k moves up/down the display lines instead of real lines",
})

cmd("Tools", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/lua/tools.lua")
end, {
  desc = "Open tools config file",
})

--- PLUGINS ---

--- Set up commands for Conform
M.conform = function()
  cmd("Format", require("util").format, {
    desc = "Format buffer",
    range = true,
  })
end

--- Set up commands for Treesitter
M.treesitter = function()
  cmd("TSStart", require("util").enable_parser, {
    desc = "Start a parser",
  })

  cmd("TSStop", vim.treesitter.stop, {
    desc = "Stop a parser",
  })
end

return M
