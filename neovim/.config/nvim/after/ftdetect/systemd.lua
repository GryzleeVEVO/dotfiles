vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Set correct filetype for systemd units",
  pattern = { "*.{automount,mount,path,slice,scope,service,socket,swap,target,timer}" },
  command = "setlocal filetype=systemd",
})
