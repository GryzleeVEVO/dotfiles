return {
  {
    "saghen/blink.cmp",
    version = "*",

    dependencies = {
      { "rafamadriz/friendly-snippets" },
    },

    --- @module "blink.cmp"
    --- @type blink.cmp.Config
    opts = {
      keymap = require("keybinds").blink,

      signature = {
        -- Show signature while filling a functiofunction
        enabled = true,
        window = {
          show_documentation = false,
        },
      },
    },
  },
}
