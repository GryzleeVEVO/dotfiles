local qolGroup = vim.api.nvim_create_augroup(
  "QualityOfLifeGroup",
  { clear = true }
)

vim.api.nvim_create_autocmd(
  "TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = qolGroup,
    callback = function()
      vim.highlight.on_yank()
    end,
  })

vim.api.nvim_create_autocmd(
  "BufWritePre", {
    desc = "Remove trailing whitespaces before saving buffer",
    group = qolGroup,
    pattern = { "*" },
    callback = function()
      local cursor = vim.fn.getpos(".")
      vim.cmd([[%s/\s\+$//e]])
      vim.fn.setpos(".", cursor)
    end,
  })
