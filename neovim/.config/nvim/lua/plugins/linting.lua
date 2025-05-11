-- local tools = require("tools")

return {
  -- "mfussenegger/nvim-lint",
  --
  -- events = { "BufEnter" },
  --
  -- config = function()
  --   require("lint").linters_by_ft = tools.linters
  --
  --   vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  --     desc = "Run linter on entry and after write",
  --     group = vim.api.nvim_create_augroup("nvim-lint-group", { clear = true }),
  --     callback = function()
  --       require("lint").try_lint()
  --     end,
  --   })
  -- end,
}
