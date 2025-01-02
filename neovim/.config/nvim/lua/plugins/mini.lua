return {
  "echasnovski/mini.nvim",

  version = "*",

  config = function()
    -- Fancy info boxes
    require("mini.notify").setup({})

    -- Add surround
    require("mini.surround").setup({})
  end,
}
