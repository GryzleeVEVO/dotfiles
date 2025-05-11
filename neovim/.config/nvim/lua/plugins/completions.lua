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
      signature = {
        enabled = true,
        window = {
          show_documentation = false,
        },
      },
    },
  },
}
