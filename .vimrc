" leader short cut
let mapleader=" "
map <leader>wq :wq<CR>
map <leader>wc :close<CR>
map <leader>wt :terminal<CR>
map <leader>q :q!<CR>

" enable status line
source ~/.vim/statusbar.vim
map <leader>nt :NERDTree<CR>

" VScode dark theme
set t_Co=256
set t_ut=
colorscheme codedark

""source ~/.vim/confplugins.vim
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

