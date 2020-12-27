setl number
color desert
set laststatus=2  " always display the status line
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
inoremap jk <ESC>
let mapleader = " "
filetype plugin indent on
syntax on
set encoding=utf-8
set nocp
set relativenumber
autocmd InsertEnter,InsertLeave * set cul!

" traversing the buffer list
nnoremap <silent> [b : bprevious<CR>
nnoremap <silent> ]b : bnext<CR>
nnoremap <silent> [B : bfirst<CR>
nnoremap <silent> ]B : blast<CR>

" expand current directory with %%
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
