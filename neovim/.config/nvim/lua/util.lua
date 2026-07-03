local M = {}

--- Format selection, or entire buffer if nothing selected
---@param args vim.api.keyset.create_user_command.command_args
M.format = function(args)
  local conform = require("conform")
  local range = nil

  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end

  conform.format({ async = true, range = range })
end

--- Start a Treesitter parser on the current buffer
M.enable_parser = function()
  local ok, _ = pcall(vim.treesitter.start)

  if not ok then
    return
  end

  vim.opt.foldcolumn = "0"
  vim.opt.foldtext = ""
  vim.opt.foldlevel = 99

  -- Folding
  vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo[0][0].foldmethod = "expr"

  -- Indenting
  vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
end

return M

