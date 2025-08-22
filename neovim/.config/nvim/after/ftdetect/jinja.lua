vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Set correct filetype for j2 (jinja) files",
  pattern = { "*.j2" },
  command = "setlocal filetype=jinja",
})
