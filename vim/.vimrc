" Disable compatibility mode
"  *** INCLUDES ***

" If vim, read plugins 
if !has('nvim') && filereadable(expand("~/.vimrc.plug"))
    source ~/.vimrc.plug
endif

"set nocompatible

" Set encoding to UTF-8 and filetype to UNIX
set encoding=utf-8
set fileformat=unix

" Enable mouse support
set mouse=a

" Copy to system clipboard
set clipboard=unnamedplus
vnoremap <C-c> "+y
map <C-p> "+p

" *** TABS ***

" Set tab size to 4
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Replace tabs with spaces
set expandtab

" Autoindent
set autoindent
filetype indent on

" *** VISUAL ***

" Syntax highlighting
syntax on

set background=dark

set termguicolors 

" Set colorscheme
colorscheme darkula

" Show status bar at the bottom  of the screen
set laststatus=2

" No wrapping 
set nowrap

" Numbers on the side
set number relativenumber

" Split windows to the right
set splitbelow splitright

" *** SEARCH ***

" Highlight searches
set hlsearch

" Incremental search
set incsearch

" *** AUTOCOMPLETE ***

" List suggestions by pressing ctrl+n when in insert mode
set wildmode=longest,list,full

" Show commands when typing
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" *** KEYBINDINGS ***

" Use , as map leader
let mapleader=","

" Switch between windows by holding ctrl
"map <C-h> <C-w>h
"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-l> <C-w>l

" Open new tab with ctrl-t 
"nnoremap <silent> <C-t> :tabnew<CR>

