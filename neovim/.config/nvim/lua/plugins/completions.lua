return {
  {
    "saghen/blink.cmp",
    version = "*",

    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "*",

        dependencies = {
          "rafamadriz/friendly-snippets",
        },

        run = "make install_jsregexp",

        config = function()
          require("luasnip.loaders.from_vscode").lazy_load({})
        end,
      },
    },

    --- @module "blink.cmp"
    --- @type blink.cmp.Config
    opts = {
      snippets = { preset = "luasnip" },
      keymap = {
        blink = {
          preset = "default",
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
        },
      },
      signature = {
        enabled = true,
        window = {
          show_documentation = false,
        },
      },

      appearance = {
        kind_icons = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      },
    },
  },
}
