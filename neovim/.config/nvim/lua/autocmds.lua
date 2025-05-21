local au = vim.api.nvim_create_autocmd
local auclr = vim.api.nvim_clear_autocmds
local ag = vim.api.nvim_create_augroup
local cmd = vim.cmd

local qol_gr = ag("qol-fixes", { clear = true })
local lsp_gr = ag("lsp-attach-setup", { clear = true })

au({ "BufEnter" }, {
  desc = "Do not insert comment prefix on line break",
  group = qol_gr,
  pattern = "",
  -- c = autowrap comment comment with textwidth
  -- r = insert prefix after linebreak
  -- o = insert prefix after new line with o and O
  command = "set formatoptions-=cro",
})

au({ "BufWritePre" }, {
  desc = "Remove trailing whitespace before saving",
  group = qol_gr,
  pattern = "",
  callback = function()
    if vim.g.enable_autoformat then
      local cursor = vim.fn.getpos(".")
      cmd([[%s/\s\+$//e]])
      vim.fn.setpos(".", cursor)
    end
  end,
})

au({ "TextYankPost" }, {
  desc = "Highlight yanked text",
  group = qol_gr,
  pattern = "",
  callback = function()
    vim.hl.on_yank()
  end,
})

au({ "BufRead", "BufNewFile" }, {
  desc = "Set correct filetype for Docker Compose files",
  group = qol_gr,
  pattern = "*docker-compose*.{yml,yaml}",
  command = "set filetype=yaml.docker-compose",
})

au({ "LspAttach" }, {
  desc = "Set up stuff on a newly attached LSP",
  group = lsp_gr,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local highlightSupported = client
      and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, ev.buf)

    if highlightSupported then
      local lsp_hl_gr = ag("lsp-highlight", { clear = false })

      au({ "CursorHold", "CursorHoldI" }, {
        desc = "Highlight references of symbol in cursor",
        group = lsp_hl_gr,
        buffer = ev.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      au({ "CursorMoved", "CursorMovedI" }, {
        desc = "Highlight",
        group = lsp_hl_gr,
        buffer = ev.buf,
        callback = vim.lsp.buf.clear_references,
      })

      au({ "LspDetach" }, {
        desc = "Clean up stuff after detaching an LSP",
        callback = function(ev2)
          vim.lsp.buf.clear_references()
          auclr({ group = "lsp-highlight", buffer = ev2.buf })
        end,
      })
    end
  end,
})
