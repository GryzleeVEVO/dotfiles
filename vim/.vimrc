set nocompatible

" Use Plug to manage plugins
call plug#begin()

" Theme
Plug 'vim-airline/vim-airline'
Plug 'ayu-theme/ayu-vim'

" Close parenthesis automatically
Plug 'tmsvg/pear-tree'

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'chiel92/vim-autoformat'

"Plug 'sheerun/vim-polyglot'

Plug 'bfrg/vim-cpp-modern'

call plug#end()

set encoding=utf-8
set mouse=a
set clipboard=unnamedplus
set history=1000
set backspace=indent,eol,start

" Colors
syntax on

set background=dark
try
    colorscheme ayu
    set termguicolors
catch
    colorscheme default
    set notermguicolors
endtry

" Hybrid line numbers
set number
set relativenumber

" 4 space tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Indentation
set autoindent
set smartindent
filetype plugin on

set nowrap

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Folding
set foldmethod=syntax
set foldlevel=99

set noswapfile
set nobackup
set wildmenu
set wildoptions=pum
set wildmode=longest,full
set autochdir
set showcmd
set laststatus=2
set undofile
set colorcolumn=80,120
set splitbelow splitright
set scrolloff=6

" Unbind arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Use Ctrl for splitting
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-v> :vsp<CR>
nnoremap <C-s> :sp<CR>

" Better tab movement
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
