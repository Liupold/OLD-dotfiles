set undodir=$XDG_DATA_HOME/nvim/undo
set directory=$XDG_DATA_HOME/nvim/swap
set backupdir=$XDG_DATA_HOME/nvim/backup
set viewdir=$XDG_DATA_HOME/nvim/view
set runtimepath=$XDG_CONFIG_HOME/nvim,$VIMRUNTIME,$XDG_CONFIG_HOME/nvim/after
set nocompatible
set viminfo+='1000,n$XDG_DATA_HOME/nvim/viminfo
set listchars=tab:\|\ ,
set list
set laststatus=2
set timeoutlen=300
set number
set relativenumber
set guifont="Fira Code 10"
set tabstop=4
set noshowmode
set t_Co=256
filetype plugin on
syntax on
"colorscheme gruvbox
colorscheme molokai
set path+=**
set wildmode=longest,list,full
set splitright
set splitbelow
set backup
set writebackup
set undofile
set undolevels=100000         " How many undos
set undoreload=100000        " number of lines to save for undo

if !has('nvim')
        set ttymouse=xterm2
endif

autocmd TermOpen * setlocal nonumber norelativenumber


" ----------------------------------------------------------
" PLUGINs
if empty(glob('$XDG_CONFIG_HOME/nvim/autoload/plug.vim'))
        silent !curl -fLo "$XDG_CONFIG_HOME/nvim/autoload/plug.vim" --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            autocmd VimEnter * PlugInstall
endif

call plug#begin('$XDG_DATA_HOME/nvim/plugged')
Plug 'kovetskiy/sxhkd-vim'
Plug 'VebbNix/lf-vim'
Plug 'dense-analysis/ale'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'jiangmiao/auto-pairs'
Plug 'cespare/vim-toml'
Plug 'vim-airline/vim-airline'
call plug#end()
let g:mkdp_browser = $BROWSER

" ----------------------------------------------------------
"  KeyMapings
let mapleader =","
noremap <F6> :set spell! spelllang=en_us<CR>
noremap <leader><leader> <Esc><Esc>:w<CR>
noremap <leader>q :q<CR>
let g:indentLine_char = '|'
noremap <leader>e :find
nnoremap <leader>t :tabedit<CR>

nnoremap <Down> :resize -1<CR>
nnoremap <Up> :resize +1<CR>
nnoremap <Left> :vertical resize +1<CR>
nnoremap <Right> :vertical resize -1<CR>

inoremap <leader><leader> <Esc><ESc>:w<CR>
nnoremap <leader>x :sp<CR>:resize 20<CR>:term <CR>
"  make term great again

if exists(':tnoremap')
        tnoremap <Esc> <C-\><C-n>
        au TermOpen * setlocal nonumber | startinsert
        au TermClose * setlocal number | call feedkeys("\<C-\>\<C-n>")
endif

" ----------------------------------------------------------
" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-l> <C-w>l
	map <C-k> <C-w>k

" ----------------------------------------------------------
" Copy And Paste

    " diffent clip for delete ;)
    noremap d "bd
    noremap dd "bdd
    noremap dw "bdw
    vnoremap dw "bdw
    vnoremap dd "bdd
    noremap pd "bp

" ----------------------------------------------------------
" Some Basic autocmd
" remove white spaces
autocmd BufWritePre * %s/\s\+$//e

" ----------------------------------------------------------
" LaTex
autocmd BufReadPre *.tex nnoremap <leader>c :sp<CR>:resize 10<CR>:term latexrun  --clean-all "%" && rm -r "%:p:h/latex.out"<CR>
" ----------------------------------------------------------
" Python autocmd
autocmd BufReadPre *.py nnoremap <leader>c :sp<CR>:resize 10<CR>:term time python3 "%" <CR>
" ----------------------------------------------------------
"  sh
autocmd BufReadPre *.sh nnoremap <leader>c :sp<CR>:resize 10<CR>:term time sh "%" <CR>
" ----------------------------------------------------------
"  octave
autocmd BufReadPre *.m nnoremap <leader>c :sp<CR>:resize 10<CR>:term time octave -q "%" <CR>
autocmd BufReadPre *.m nnoremap <leader>p :sp<CR>:resize 10<CR>:term time octave --persist -q "%" <CR>

" ----------------------------------------------------------
"  c
autocmd BufReadPre *.c nnoremap <leader>c :sp<CR>:resize 10<CR>:term gcc "%" -o "%.out" -lm && time ./"%.out" && rm ./"%.out"<CR>
autocmd BufReadPre *.cpp nnoremap <leader>c :sp<CR>:resize 10<CR>:term gcc -lm "%" -o "%.out" -lstdc++ && time ./"%.out" && rm ./"%.out"<CR>
autocmd BufReadPre *.asm nnoremap <leader>c :sp<CR>:resize 10<CR>:term nasm -f elf32 "%" -o "%.o" && ld -m elf_i386 %.o -o "%.out" && rm "%.o" && ./"%.out"<CR>
