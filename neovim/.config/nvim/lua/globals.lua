local g = vim.g

--- When enabled, the file will be formatted before saving. Leading whitespaces
--- will be trimmed, and a formatter is run if available using Conform.
g.autoformat = true

--- When enabled, j/k behaves like gj/gk, that is, move one display line up by
--- default when lines are wrapped instead of moving one real line up.
---
--- This is ignored when j/k is used with a count
g.up_down_display_lines = true

-- Use the Windows clipboard when using WSL. If within a TMUX session, fall back
-- to TMUX handling the clipboard, since it already uses the WSL clipboard
if vim.fn.has("wsl") == 1 and not vim.env.TMUX then
  local paste_cmd = table.concat({
    "powershell.exe",
    "-NoLogo",
    "-NoProfile",
    "-c",
    '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  }, " ")

  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = paste_cmd,
      ["*"] = paste_cmd,
    },
    cache_enabled = 0,
  }
end
