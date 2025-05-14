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
      keymap = {
        preset = "default",

        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },

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
