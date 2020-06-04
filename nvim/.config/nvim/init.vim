set undodir=$XDG_DATA_HOME/nvim/undo
set directory=$XDG_DATA_HOME/nvim/swap
set backupdir=$XDG_DATA_HOME/nvim/backup
set viewdir=$XDG_DATA_HOME/nvim/view
set runtimepath=$XDG_CONFIG_HOME/nvim,$VIMRUNTIME,$XDG_CONFIG_HOME/nvim/after
set nocompatible
set viminfo+='1000,n$XDG_DATA_HOME/nvim/viminfo

set laststatus=2
set timeoutlen=300
set number
set relativenumber
set guifont="Fira Code 10"
set expandtab
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
set backupcopy=yes

if !has('nvim')
        set ttymouse=xterm2
endif

" ----------------------------------------------------------
set showtabline=1
set tabline="%1T"

let g:currentmode={
      \ 'n'  : 'N ',
      \ 'no' : 'N·Operator Pending ',
      \ 'v'  : 'V ',
      \ 'V'  : 'V·Line ',
      \ 'x22' : 'V·Block ',
      \ 's'  : 'Select ',
      \ 'S'  : 'S·Line ',
      \ 'x19' : 'S·Block ',
      \ 'i'  : 'I ',
      \ 'R'  : 'R ',
      \ 'Rv' : 'V·Replace ',
      \ 'c'  : 'Command ',
      \ 'cv' : 'Vim Ex ',
      \ 'ce' : 'Ex ',
      \ 'r'  : 'Prompt ',
      \ 'rm' : 'More ',
      \ 'r?' : 'Confirm ',
      \ '!'  : 'Shell ',
      \ 't'  : 'Terminal '
      \}


" Find out current buffer's size and output it.
function! FileSize()
        let bytes = getfsize(expand('%:p'))
        if (bytes >= 1024)
                let kbytes = bytes / 1024
        endif
        if (exists('kbytes') && kbytes >= 1000)
                let mbytes = kbytes / 1000
        endif

        if bytes <= 0
                return '0'
        endif

        if (exists('mbytes'))
                return mbytes . 'MB '
        elseif (exists('kbytes'))
                return kbytes . 'KB '
        else
                return bytes . 'B '
        endif
endfunction

function! ReadOnly()
        if &readonly || !&modifiable
                return ''
        else
                return ''
endfunction

set laststatus=2
set statusline=
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=%8*\ [%n]                                " buffernr
set statusline+=%8*\ %<%F\ %{ReadOnly()}\ %m\ %w\        " File+path
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%9*\ %=                                  " Space
set statusline+=%8*\ %y\                                 " FileType
set statusline+=%7*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ " Encoding & Fileformat
set statusline+=%8*\ %-3(%{FileSize()}%)                 " File size
set statusline+=%0*\ %3p%%\ \ %l\|%L:\ %3c\                 " Rownumber/total (%)

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
call plug#end()

" ----------------------------------------------------------
"  KeyMapings
let mapleader =","
noremap <F6> :set spell! spelllang=en_us<CR>
noremap <leader><leader> <Esc><Esc>:w<CR>
noremap <leader>q :q<CR>

noremap <leader>e :find
nnoremap <leader>t :tabedit<CR>
nnoremap <leader>v :tabprevious<CR>
nnoremap <leader>b :tabnext<CR>

nnoremap <Down> :resize -1<CR>
nnoremap <Up> :resize +1<CR>
nnoremap <Left> :vertical resize +1<CR>
nnoremap <Right> :vertical resize -1<CR>

inoremap <leader><leader> <Esc><ESc>:w<CR>
inoremap <leader><Space> <Esc><Esc>/<CR>"_c4l

" ----------------------------------------------------------
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
" Backup (or cry).
    au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
"   Remove older backup
    au BufWritePre * :silent !find $XDG_DATA_HOME/nvim/backup/* -mtime +30 -delete

" ----------------------------------------------------------
" LaTex
	autocmd BufReadPre *.tex nnoremap <F5> :sp<CR>:resize 10<CR>:term latexrun.py  --clean-all "%" <CR>
	autocmd BufReadPre *.tex nnoremap <leader>c :sp<CR>:resize 10<CR>:term latexrun.py  --clean-all "%" <CR>

" ----------------------------------------------------------
" Python autocmd
	autocmd BufReadPre *.py nnoremap <F5> :sp<CR>:resize 10<CR>:term time python "%"<CR>
	autocmd BufReadPre *.py nnoremap <leader>c :sp<CR>:resize 10<CR>:term time python "%" <CR>

" ----------------------------------------------------------
"  sh
	autocmd BufReadPre *.sh nnoremap <F5> :sp<CR>:resize 10<CR>:term time sh "%"<CR>
	autocmd BufReadPre *.sh nnoremap <leader>c :sp<CR>:resize 10<CR>:term time sh "%" <CR>

