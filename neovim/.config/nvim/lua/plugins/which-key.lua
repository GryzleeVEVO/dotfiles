---@type LazySpec
return {
  -- Shows available keymaps on key press
  "folke/which-key.nvim",

  event = "VeryLazy",

  keys = require("keymap").which_key(),

  opts = {
    preset = "helix",
  },
}
