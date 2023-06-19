set nu
set ts=4
set autoindent
set hlsearch
set incsearch
set ignorecase
set ruler
set mouse=a
set cursorline
syntax on

inoremap ' ''<ESC>i
inoremap '' ''

inoremap " ""<ESC>i
inoremap "" ""

inoremap ( ()<ESC>i
inoremap () ()

inoremap [ []<ESC>i
inoremap [] []

inoremap { {}<ESC>i
inoremap {} {}
inoremap {<CR> {<CR>}<ESC>O<TAB>

inoremap < <><ESC>i
inoremap <> <>
inoremap << <<

" leader short cut
let mapleader=" "
map <leader>wq :wq<CR>
map <leader>wc :close<CR>
map <leader>wt :terminal<CR>

" enable status line
source ~/.vim/statusbar.vim
source ~/.vim/loadplugins.vim
source ~/.vim/confplugins.vim

