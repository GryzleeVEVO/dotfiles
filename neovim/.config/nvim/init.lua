-- Before doing anything, disable NetRW. We'll re-enable part of it later
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("opts")
require("diagnostics")
require("autocmds")
require("keybinds")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- All plugins are in lua/plugins
    { import = "plugins" },
  },
  checker = {
    -- Automatically check for updates, just don't bother
    enabled = true,
    notify = false,
  },
  change_detection = {
    -- Don't nag with config change messages
    notify = false,
  },
})

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Update plugins automatically",
  callback = function()
    require("lazy").update({ show = false })
  end,
})
