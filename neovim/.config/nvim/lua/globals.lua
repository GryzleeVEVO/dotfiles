local g = vim.g

--- When enabled, the file will be formatted before saving. Leading whitespaces
--- will be trimmed, and a formatter is run if available using Conform.
g.autoformat = true

--- When enabled, j/k behaves like gj/gk, that is, move one display line up by
--- default when lines are wrapped instead of moving one real line up.
---
--- This is ignored when j/k is used with a count
g.up_down_display_lines = true
