---@type LazySpec
return {
  -- File explorer
  "stevearc/oil.nvim",

  dependencies = {
    "nvim-web-devicons",
  },

  lazy = false,

  opts = {},

  keys = require("keymap").oil,
}
