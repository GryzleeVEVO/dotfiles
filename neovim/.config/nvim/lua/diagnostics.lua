vim.diagnostic.config({
  -- Show text alongside the offending line of code
  -- virtual_text = {},

  -- Show lines under offending line of code
  -- virtual_lines = {},

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.INFO] = "󰋽",
      [vim.diagnostic.severity.HINT] = "󰌶",
    },
  },
})
