-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Default 4 space tabs + overrides for 2 spaces tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd( "FileType", {
    pattern = "html,js,css,php",
    command = 'setlocal tabstop = 2 softtabstop = 2 shiftwidth = 2'
})

-- Render whitespaces
vim.opt.list = true
vim.opt.listchars = 'trail:~,tab:>-,nbsp:␣'

-- Disable wrapping
vim.opt.wrap = false

-- Better search highlighting
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Indent next line if necessary
vim.opt.smartindent = true

-- Top off cursor when scrollingç
vim.opt.scrolloff = 8

-- Do not add comment in next line in any language
vim.api.nvim_create_autocmd( "FileType", {
    pattern = "*",
    command = 'setlocal formatoptions-=cro'
})

-- Only one column if there are no errors/warnings
vim.opt.signcolumn = 'number'

-- Length markers
vim.opt.colorcolumn = '80,120'

-- Do not store swaps or backups
vim.opt.swapfile = false
vim.opt.backup = false

-- Update faster
vim.opt.updatetime = 50

-- Do not add automatic comments
vim.opt.formatoptions:remove('cro')

-- Better command line completion
vim.opt.wildmenu = true

-- If no file/directory is open on start, open netrw
vim.api.nvim_create_autocmd( "VimEnter", {
    pattern = "*",
    command = 'if !argc() | Explore | endif'
})
