" Leader and mapleader{{
inoremap jk <ESC>
let mapleader = " "
"}}
" Visuals{{
set number
set relativenumber
color desert
set showcmd             " show command in bottom bar
set wildmenu            "visual autocomplete for command menu
set laststatus=2  " always display the status line
autocmd InsertEnter,InsertLeave * set cul!
set showmatch           "highlight matching brackets [{()}]
syntax enable
"}}
" Hlsearches{{
set incsearch       "Search as characters are entered
set hlsearch        " highligh matches
nnoremap <leader>. :set hlsearch<CR>
nnoremap <leader>, :nohlsearch<CR>
"}}
" tabs{{
set tabstop=4 "number of visual spaces per tab
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces
"}}
" traversing the buffer list{{
nnoremap <silent> [b : bprevious<CR>
nnoremap <silent> ]b : bnext<CR>
nnoremap <silent> [B : bfirst<CR>
nnoremap <silent> ]B : blast<CR>
"}}
" Move to beginning/end of line{{
nnoremap B ^
nnoremap E $
"}}
" folding text{{
set foldenable
set foldlevelstart=0   " open most folds by default
set foldnestmax=10      " 10 nested fold max
nnoremap <leader>z za
set foldmethod=marker
set foldmarker={{,}}
"}}
" edit vimrc/zshrc and load vimrc bindings{{
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
"}}
" Various{{
set lazyredraw          "only redraws screen when we have to
filetype indent on " load filetype specific indent files
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
filetype plugin indent on
set encoding=utf-8
set nocp"

" highlight last inserted text
nnoremap gV `[v`]
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" expand current directory with %%
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


" save session, open with vim -S
nnoremap <leader>s :mksession<CR>
"}}
