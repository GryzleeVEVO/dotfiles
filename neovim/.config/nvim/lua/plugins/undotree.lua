---@type LazySpec
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

  keys = require("keymap").undotree,
}
