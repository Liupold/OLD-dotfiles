set undodir=$XDG_DATA_HOME/nvim/undo
set directory=$XDG_DATA_HOME/nvim/swap
set backupdir=$XDG_DATA_HOME/nvim/backup
set viewdir=$XDG_DATA_HOME/nvim/view
set runtimepath=$XDG_CONFIG_HOME/nvim,$VIMRUNTIME,$XDG_CONFIG_HOME/nvim/after
"set nocompatible
set viminfo+='1000,n$XDG_DATA_HOME/nvim/viminfo
set listchars=tab:\|\ ,
set list
set laststatus=2
set timeoutlen=300
set number
set relativenumber
set guifont="Fira Code 10"
set noshowmode
set autoindent expandtab tabstop=2 shiftwidth=2
set t_Co=256
filetype plugin on
syntax on
"colorscheme gruvbox
colorscheme koehler
"colorscheme molokai
highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
if has("termguicolors")     " set true colors
    set t_8f=\[[38;2;%lu;%lu;%lum
    set t_8b=\[[48;2;%lu;%lu;%lum
    set termguicolors
endif
set path+=**
set wildmode=longest,list,full
set splitright
set splitbelow
set backup
set writebackup
set undofile
set undolevels=100000         " How many undos
set undoreload=100000        " number of lines to save for undo
let g:grammarous#use_vim_spelllang=1

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
"Plug 'dense-analysis/ale'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'cespare/vim-toml'
Plug 'vim-airline/vim-airline'
Plug 'rhysd/vim-grammarous'
Plug 'JuliaEditorSupport/julia-vim'
call plug#end()
let g:mkdp_browser = $BROWSER

" ----------------------------------------------------------
"  KeyMapings
let mapleader =","
noremap <F6> :set spell! spelllang=en_us<CR>
noremap <leader><leader> <Esc><Esc>:w<CR>
nnoremap <leader>d "=strftime('<<<<<<<<<<<<<<< %c >>>>>>>>>>>>>>>')<CR>P
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
autocmd BufReadPre *.tex nnoremap <leader>c :sp<CR>:resize 10<CR>:term cd "%:p:h" && latexrun  --clean-all "%:p" && rm -r "%:p:h/latex.out"<CR>
autocmd BufReadPre *.tex nnoremap <leader>p :!zathura --fork "%:p:r.pdf"<CR>
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
autocmd BufReadPre *.c nnoremap <leader>c :sp<CR>:resize 10<CR>:term gcc -Wall -Wpedantic -Wextra "%" -o "%.out" -lm && time ./"%.out" && rm ./"%.out"<CR>
autocmd BufReadPre *.cpp nnoremap <leader>c :sp<CR>:resize 10<CR>:term gcc -Wall -Wpedantic -Wextra -lm "%" -o "%.out" -lstdc++ && time ./"%.out" && rm ./"%.out"<CR>
autocmd BufReadPre *.asm nnoremap <leader>c :sp<CR>:resize 10<CR>:term nasm -f elf32 "%" -o "%.o" && ld -m elf_i386 %.o -o "%.out" && rm "%.o" && ./"%.out"<CR>
"  go
autocmd BufReadPre *.go nnoremap <leader>c :sp<CR>:resize 10<CR>:term go run "%" <CR>
" ----------------------------------------------------------
"  R
autocmd BufReadPre *.r nnoremap <leader>c :sp<CR>:resize 10<CR>:term time Rscript "%" <CR>
" ----------------------------------------------------------
"  Julia
autocmd BufReadPre *.jl nnoremap <leader>c :sp<CR>:resize 10<CR>:term time julia "%" <CR>
" ----------------------------------------------------------
"  Fortan90
autocmd BufReadPre *.f90 nnoremap <leader>c :sp<CR>:resize 10<CR>:term gfortran "%" -o "%.out" -lm && time ./"%.out" && rm ./"%.out"<CR>
" ----------------------------------------------------------
"  Fortan90
autocmd BufReadPre config.h nnoremap <leader>c :sp<CR>:resize 10<CR>:term cd "%:p:h" && sudo make install <CR>
" ----------------------------------------------------------
"  ng-spice
autocmd BufNewFile,BufReadPre *.spc,*.sp,*.cir set filetype=spice
autocmd BufNewFile,BufReadPre *.cir nnoremap <leader>c :sp<CR>:resize 10<CR>:term time ngspice "%" <CR>
" ----------------------------------------------------------
"  R
autocmd BufReadPre *.R nnoremap <leader>c :sp<CR>:resize 10<CR>:term Rscript "%"<CR>
" ----------------------------------------------------------
