local M = {}

local keymap = require("keymap")

local au = vim.api.nvim_create_autocmd
local auclr = vim.api.nvim_clear_autocmds
local aug = vim.api.nvim_create_augroup
local cmd = vim.cmd

-- Set up autocommand groups
local editor_group = aug("editor-quality-of-life", { clear = true })
local lsp_group = aug("lsp-attach-setup", { clear = true })

--- Editing ---

-- Since formatoptions is set per buffer, we ned an autocommandt to disable it
-- every time
au({ "BufEnter" }, {
  desc = "Disable inserting new comments on line break",
  group = editor_group,
  pattern = "",
  -- c = autowrap comment comment with textwidth
  -- r = insert prefix after linebreak
  -- o = insert prefix after new line with o and O
  command = "set formatoptions-=cro",
})

au({ "BufWritePre" }, {
  desc = "Remove trailing whitespace before saving",
  group = editor_group,
  pattern = "",
  callback = function()
    if vim.g.autoformat then
      local cursor = vim.fn.getpos(".")
      cmd([[%s/\s\+$//e]])
      vim.fn.setpos(".", cursor)
    end
  end,
})

--- Visual ---

au({ "TextYankPost" }, {
  desc = "Highlight yanked text",
  group = editor_group,
  pattern = "",
  callback = function()
    vim.hl.on_yank()
  end,
})

--- LSP ---

au({ "LspAttach" }, {
  desc = "Configure newly attached LSP",
  group = lsp_group,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local highlightSupported = client
      and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, ev.buf)

    if highlightSupported then
      local lsp_highlight_group = aug("lsp-highlight-setup", { clear = true })

      au({ "CursorHold", "CursorHoldI" }, {
        desc = "Highlight references to symbol in cursor",
        group = lsp_highlight_group,
        buffer = ev.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      au({ "CursorMoved", "CursorMovedI" }, {
        desc = "Remove highlights to symbol when moving cursor",
        group = lsp_highlight_group,
        buffer = ev.buf,
        callback = vim.lsp.buf.clear_references,
      })

      au({ "LspDetach" }, {
        desc = "Clean up highlight autocommands when detaching an LSP",
        callback = function(ev2)
          vim.lsp.buf.clear_references()
          auclr({
            group = lsp_highlight_group,
            buffer = ev2.buf,
          })
        end,
      })
    end
  end,
})

au({ "LspAttach" }, {
  desc = "Set up keybindings after attaching an LSP",
  group = lsp_group,
  callback = keymap.lsp,
})

--- PLUGINS ---

--- Set up autocommands for Treesitter
M.treesitter = function()
  local treesitter_group = aug("treesitter-plugin", { clear = true })

  au("FileType", {
    desc = "Start Treesitter when opening a file",
    group = treesitter_group,
    pattern = { "*" },
    callback = require("util").enable_parser,
  })
end

return M
