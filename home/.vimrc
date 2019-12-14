" SET VARS
set nocompatible
set laststatus=2
set timeoutlen=300
set number
set relativenumber
set guifont=Fira\ Code\ 10
" set termguicolors
set expandtab
set tabstop=4
colorscheme molokai
set t_Co=256

" ----------------------------------------------------------
" BASIC

filetype plugin on
syntax on
let mapleader =","
set wildmode=longest,list,full
set splitright
set splitbelow

" ----------------------------------------------------------
" PLUGINs

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'kovetskiy/sxhkd-vim'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

let g:syntastic_always_populate_loc_list = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='term'

" ----------------------------------------------------------
" KeyMapings
map <F5> :w<Esc>:ter vim-compiler.sh "%"<CR>
map <F6> :set spell! spelllang=en_us<CR>
map <leader>q :q<CR>

inoremap  <leader><Space> <Esc><Esc>/<++><CR>"_c4l
inoremap <leader>z <c-o>:u<CR>i
inoremap <leader>x <Esc><c-r>i
inoremap <leader><leader> <Esc><Esc>:w<CR>
inoremap <leader>s <Esc><Esc>:w<CR>i
inoremap <leader>c <Esc><Esc>:w<Esc>:ter vim-compiler.sh "%"<CR>


" ----------------------------------------------------------
" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
" ----------------------------------------------------------
" Copy And Paste
	vnoremap <C-c> +y
	map <C-p> +p
	inoremap <C-p> <Esc><Esc>p<CR>i

" ----------------------------------------------------------
" Some Basic autocmd
	autocmd BufWritePre * %s/\s\+$//e

" ----------------------------------------------------------
" LaTex
"	autocmd BufWritePost *.tex !vim-compiler %
