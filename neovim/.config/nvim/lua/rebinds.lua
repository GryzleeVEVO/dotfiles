-- Custom rebinds 

-- Use space as leader
vim.g.mapleader = ' '

-- Unmap arrow keys for navigation
vim.api.nvim_set_keymap('n', '<up>', '<nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<down>', '<nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<left>', '<nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<right>', '<nop>', { noremap = true, silent = true })


-- Toggle Netrw with leader + e
function ToggleNetrw()
    if vim.bo.filetype == 'netrw' then
        -- Go back to the previous buffer
        vim.cmd 'bprevious'
    else
        -- Open Netrw
        vim.cmd 'Explore'
    end
end


vim.api.nvim_set_keymap('n', '<leader>e', ':lua ToggleNetrw()<CR>', { noremap = true, silent = true })

-- TABS

-- Create new tab with leader + t
vim.api.nvim_set_keymap('n', '<leader>t', ':tabnew<CR>', { noremap = true, silent = true })

-- Open a file in a new tab with leader + T
vim.api.nvim_set_keymap('n', '<leader>T', ':tabnew ', { noremap = true, silent = false})

-- Close current tab with leader + Q (using q with only one split also closes the tab)
vim.api.nvim_set_keymap('n', '<leader>Q', ':tabclose<CR>', { noremap = true, silent = true })

-- Move to tab using leader + number
for i = 1, 9 do
    vim.api.nvim_set_keymap('n', '<leader>'..i, ':'..i..'tabnext<CR>', { noremap = true, silent = true })
end

-- Move around tabs with leader + ctrl + hj
vim.api.nvim_set_keymap('n', '<leader><C-h>', ':tabprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><C-l>', ':tabnext<CR>', { noremap = true, silent = true })

-- WINDOWS

-- Split window horizontally with leader + h
vim.api.nvim_set_keymap('n', '<leader>h', ':split<CR>', { noremap = true, silent = true })

-- Split window vertically with leader + v
vim.api.nvim_set_keymap('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true })

-- Open new file in a horizontal split with leader + H
vim.api.nvim_set_keymap('n', '<leader>H', ':split ', { noremap = true, silent = false})

-- Open new file in a vertical split with leader + V
vim.api.nvim_set_keymap('n', '<leader>V', ':vsplit ', { noremap = true, silent = false})

-- Close window with leader + q
vim.api.nvim_set_keymap('n', '<leader>q', ':close<CR>', { noremap = true, silent = true })

-- Move between windows with Ctrl + hjkl
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Move windows with Shift + Ctrl + hjkl
vim.api.nvim_set_keymap('n', '<S-C-h>', '<C-w>H', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-C-j>', '<C-w>J', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-C-k>', '<C-w>K', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-C-l>', '<C-w>L', { noremap = true, silent = true })
