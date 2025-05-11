local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local cmd = vim.cmd

local qol_gr = ag("qol-fixes", { clear = true })

au({ "BufEnter" }, {
  desc = "Do not insert comment prefix on line break",
  group = qol_gr,
  pattern = "",
  -- c = autowrap comment comment with textwidth
  -- r = insert prefix after linebreak
  -- o = insert prefix after new line with o and O
  command = "set formatoptions-=cro",
})

au({ "BufWritePre" }, {
  desc = "Remove trailing whitespace before saving",
  group = qol_gr,
  pattern = "",
  callback = function()
    if vim.g.enable_autoformat then
      return
    end
    local cursor = vim.fn.getpos(".")
    cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", cursor)
  end,
})

au({ "TextYankPost" }, {
  desc = "Highlight yanked text",
  group = qol_gr,
  pattern = "",
  callback = function()
    vim.hl.on_yank()
  end,
})

au({ "BufRead", "BufNewFile" }, {
  desc = "Set correct filetype for Docker Compose files",
  group = qol_gr,
  pattern = "*docker-compose*.{yml,yaml}",
  command = "set filetype=yaml.docker-compose",
})
