return {
  -- Undo history
  "mbbill/undotree",

  cmd = {
    "UndotreeFocus",
    "UndotreeHide",
    "UndotreePersistUndo",
    "UndotreeShow",
    "UndotreeToggle",
  },

  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "[undotree] Toggle undo tree" },
  },
}
