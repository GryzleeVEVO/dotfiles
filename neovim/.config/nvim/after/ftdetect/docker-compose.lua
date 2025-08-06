vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Set correct filetype for Docker Compose files",
  pattern = { "*docker-compose*.{yml,yaml}" },
  command = "setlocal filetype=yaml.docker-compose",
})
