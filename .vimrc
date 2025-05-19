" leader short cut
let mapleader=" "
map <leader>wq :wq<CR>
map <leader>wc :close<CR>
map <leader>wt :terminal<CR>
map <leader>w :w!<CR>
map <leader>q :q!<CR>
map <leader>sp :sp<CR>
map <leader>vsp :vsp<CR>

" enable status line
source ~/.vim/statusbar.vim
map <leader>nt :NERDTree<CR>

" VScode dark theme
set t_Co=256
set t_ut=
colorscheme codedark

"source ~/.vim/confplugins.vim
set nu
"set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set hlsearch
set incsearch
set ignorecase
set ruler
set mouse=a
set cursorline
set showtabline=1
set foldmethod=indent
autocmd! BufNewFile,BufRead *, setlocal nofoldenable
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

