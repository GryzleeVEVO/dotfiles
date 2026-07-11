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

--- Return a list of tools to be installed by Mason automatically. If a package
--- manager is unavailable, skip installing the packages.
---@param t table List of tools per package manager.
---@return table mason_tools Flat list of tools to be installed by Mason
M.create_mason_install_list = function(t)
  local res = {}

  for k, v in pairs(t) do
    if type(k) == "number" and type(v) == "string" then
      table.insert(res, v)
    elseif vim.fn.executable(k) == 1 then
      for _, tool in pairs(v) do
        table.insert(res, tool)
      end
    end
  end

  return res
end

--- Reverse a list of filetypes per formatter to a list of formatters per
--- filetype.
---@param f table List of filetypes per formatter
---@return table conform_formatters List of formatters per filetype
M.create_conform_formatter_list = function(f)
  local res = {}

  for tool, fts in pairs(f) do
    for _, ft in ipairs(fts) do
      if not res[ft] then
        res[ft] = {}
      end

      table.insert(res[ft], tool)
    end
  end

  return res
end

return M
