---@type LazySpec
return {
  {
    -- Auto complete
    "saghen/blink.cmp",
    version = "1.*",

    dependencies = {
      {
        -- Snippet engine
        "L3MON4D3/LuaSnip",
        version = "*",

        dependencies = {
          -- Snippets
          "rafamadriz/friendly-snippets",
        },

        run = "make install_jsregexp",

        config = function()
          require("luasnip.loaders.from_vscode").lazy_load({})
        end,
      },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = "luasnip" },

      keymap = require("keymap").blink,

      signature = {
        enabled = true, -- Show function signature when filling in arguments
        window = {
          show_documentation = true, -- Show docs by default
        },
      },

      completion = {
        ghost_text = {
          enabled = false, -- Show suggestion as ghost text
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
