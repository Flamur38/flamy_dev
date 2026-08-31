" --- Sanity
set nocompatible
set encoding=utf-8
set number relativenumber     " hybrid: abs on cursor, relative above/below
set scrolloff=8               " keep 8 lines visible above/below cursor

" --- Search
set ignorecase smartcase      " case-insensitive unless you type uppercase
set hlsearch incsearch
nnoremap <Esc> :noh<CR>       " Esc clears highlight

" --- Tabs / indent
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set autoindent smartindent

" --- Usability
set wildmenu wildmode=longest:full,full   " better tab completion in :command
set hidden                                " switch buffers without saving
set backspace=indent,eol,start
set clipboard=unnamedplus                 " yank goes to system clipboard
set updatetime=300

" --- Visual
set laststatus=2
set statusline=%f\ %m%r\ %=%l/%L\ col\ %c

" --- Leader shortcuts
let mapleader = " "
nnoremap <leader>e :Explore<CR>         " file browser
nnoremap <leader>/ :noh<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :bd<CR>

" --- Buffer nav
nnoremap <Tab>   :bn<CR>
nnoremap <S-Tab> :bp<CR>
