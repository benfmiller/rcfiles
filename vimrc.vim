" Mapleader{{
inoremap jk <ESC>
let mapleader = " "
"}}
" Visuals{{
set number
set relativenumber
color elflord
set showcmd             " show command in bottom bar
set wildmenu            "visual autocomplete for command menu
autocmd InsertEnter,InsertLeave * set cul!
set showmatch           "highlight matching brackets [{()}]
syntax enable
set scrolloff=8
"}}
" Statusline{{
set laststatus=2  " always display the status line

function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%<
set statusline+=%{StatuslineGit()}
set statusline+=%F
set statusline+=%h
set statusline+=%m
set statusline+=%r
set statusline+=%=char-val\ %b\ 0x%B
set statusline+=\ \ line:%l\ col:%c%V
set statusline+=\ %p%%
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
set shiftwidth=4    " for >
set expandtab       " tabs are spaces
"}}
" traversing the lists{{
" Buffer list
nnoremap <silent> [b : bprevious<CR>
nnoremap <silent> ]b : bnext<CR>
nnoremap <silent> [B : bfirst<CR>
nnoremap <silent> ]B : blast<CR>

"" Argument List
"nnoremap <silent> [a : bprevious<CR>
"nnoremap <silent> ]a : bnext<CR>
"
"" Location List
"nnoremap <silent> [l : lprev<CR>
"nnoremap <silent> ]l : lnext<CR>
"
"" Quickfix List
"nnoremap <silent> [q : cprev<CR>
"nnoremap <silent> ]q : cnext<CR>
"}}
" Move to beginning/end of line{{
nnoremap B ^
nnoremap E $
"}}
" edit vimrc/zshrc and load vimrc bindings{{
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>rv :source $MYVIMRC<CR>
"}}
" Noremaps{{

" folding text{{
set foldenable
set foldlevelstart=0   " open most folds by default
set foldnestmax=10      " 10 nested fold max
nnoremap <leader>z za
set foldmethod=marker
set foldmarker={{,}}
"}}

" highlight last inserted text
nnoremap gV `[v`]

" expand current directory with %%
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Moves up line visually
nnoremap j gj
nnoremap k gk

" save session, open with vim -S
nnoremap <leader>S :mksession<CR>
" save file
nnoremap <leader>w :w<CR>
" nnoremap <leader>x :x<CR>
nnoremap <leader>qq :q<CR>
nnoremap <leader>Q :q!<CR>

" gs sorts paragraph
nnoremap gs gsip

" Alternates spellchecking
" Jump around with [s ]s, suggestions z=, zg add to spell file, zw remove from
" spell file, zug undo zw or zg
" nnoremap <leader>k :set spell!<CR>
" I used the unimpaired vim plugin, [os or ]os

" for incrementing numbers
nnoremap <leader>i <C-a>

" insert brackets niftily
inoremap { {<CR>}<Esc>O
inoremap ( ()<Esc>i
inoremap [ []<Esc>i

" & runs previous substitution with previous flags, used when ammending sub
" command
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"Visual selection the X to search for that selection. not work with . and *
vmap X y/<C-R>"<CR>

"centers screen when moving during search
noremap <Leader>n nzz
noremap <Leader>N Nzz

" resize windows proportionally
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>> :exe "resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>< :exe "resize " . (winwidth(0) * 2/3)<CR>

" }}
" Various{{
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
set lazyredraw          "only redraws screen when we have to
filetype indent on " load filetype specific indent files
filetype plugin indent on
filetype plugin on
set encoding=utf-8
set nocompatible
set ignorecase
set hidden

" For pasting from system clipboard
set pastetoggle=<f4>
"
" fill search field with last search with <C-r>/

" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'
"}}
" Filetype setters{{

" au filetype python setlocal mp=python3\ %
" au filetype java setlocal mp=javac\ %
" au filetype c setlocal mp=gcc\ -Werror\ -Wextra\ -Wall\ -ansi\ -pedantic-errors\ -g\ -lm\ %
" au filetype cpp setlocal mp=gcc\ -Werror\ -Wextra\ -Wall\ -ansi\ -pedantic-errors\ -g\ -lm\ %
" }}
