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

" enable vscode theme
set background=dark
try
	"set t_Co=256
	"set t_ut=
	colorscheme codedark
catch
	try
		colorscheme desert
	catch
		colorscheme default
	endtry
endtry

" enable status line
source /home/fredom/.vim/statusbar.vim

