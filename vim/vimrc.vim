" Mapleader{{
inoremap jk <ESC>
tnoremap jk <C-\><C-n>
let mapleader = " "
"}}
" Visuals{{
set number
set relativenumber
" nnoremap <leader>nn :set number!<CR>:set relativenumber!<CR>
" set termguicolors!
" color elflord
set showcmd             " show command in bottom bar
set wildmenu            "visual autocomplete for command menu
autocmd InsertEnter,InsertLeave * set cul!
set showmatch           "highlight matching brackets [{()}]
syntax enable
set scrolloff=8

set mouse=nv

set cmdheight=2

" Tabs {{
" TabLine     tab pages line, not active tab page label gui=NONE guibg=#3e4452 guifg=#abb2bf
" TabLineFill tab pages line, where there are no labels
" TabLineSel  tab pages line, active tab page label      gui=NONE guibg=#1D6E02 guifg=#ffffff

hi TabLineSel cterm=NONE term=NONE ctermfg=232 ctermbg=154
hi TabLine        cterm=NONE term=NONE ctermfg=cyan ctermbg=black

" Tab number function {{
set tabline=%!MyTabLine()  " custom tab pages line
function MyTabLine()
        let s = '' " complete tabline goes here
        " loop through each tab page
        for t in range(tabpagenr('$'))
                " set highlight
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " set the tab page number (for mouse clicks)
                let s .= '%' . (t + 1) . 'T'
                let s .= ' '
                " set page number string
                let s .= t + 1 . ' '
                " get buffer names and statuses
                let n = ''      "temp string for buffer names while we loop and check buftype
                let m = 0       " &modified counter
                let nameCounter = 0 " filenames per tab
                let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
                " loop through each buffer in a tab
                for b in tabpagebuflist(t + 1)
                        " buffer types: quickfix gets a [Q], help gets [H]{base fname}
                        " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
                        if getbufvar( b, "&buftype" ) == 'help'
                            if nameCounter == 0
                                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
                            endif
                        elseif getbufvar( b, "&buftype" ) == 'quickfix'
                            if nameCounter == 0
                                let n .= '[Q]'
                            endif
                        else
                            if nameCounter == 0
                                let n .= pathshorten(bufname(b))
                            endif
                        endif
                        " check and ++ tab's &modified count
                        if getbufvar( b, "&modified" )
                                let m += 1
                        endif
                        " no final ' ' added...formatting looks better done later
                        let nameCounter += 1
                        let bc -= 1
                endfor
                if nameCounter > 1
                    let n .= ' {' . (nameCounter) .'}'
                endif
                " if bc > 1 && nameCounter < 1
                "         let n .= ' '
                " endif
                " add modified label [n+] where n pages in tab are modified
                if m > 0
                        let s .= '[' . m . '+]'
                endif
                " select the highlighting for the buffer names
                " my default highlighting only underlines the active tab
                " buffer names.
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " add buffer names
                if n == ''
                        let s.= '[New]'
                else
                        let s .= n
                endif
                " switch to no underlining and add final space to buffer list
                let s .= ' '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
                let s .= '%=%#TabLineFill#%999Xclose'
        endif
        return s
endfunction " }}
" }}
" Statusline{{
set laststatus=2  " always display the status line

" function! GitBranch()
"     return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" endfunction

" function! StatuslineGit()
"     let l:branchname = GitBranch()
"     return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
" endfunction
" %-0{minwid}.{maxwid}{item}
" pathshorten()
"
set statusline=
" set statusline+=%1*%{StatuslineGit()}\|%*
set statusline+=%1*\ %{gitbranch#name()}\ \|%*
set statusline+=%2*\ %f\ \|%*
set statusline+=\ %<
" set statusline+=%{pathshorten(\"%F\")}
set statusline+=%-0.30F
set statusline+=%h
set statusline+=%3*%m
set statusline+=%r%*
set statusline+=\ \|%5*\ Buff[%n]
set statusline+=\ %*%=[char\ %b\ 0x%B]\ \|
set statusline+=\ line:%l\ col:%c%V
set statusline+=\ %p%%


hi Statusline cterm=NONE term=NONE ctermfg=232 ctermbg=191
" Not Current
hi StatuslineNC cterm=NONE term=NONE ctermfg=232 ctermbg=248
"Git
hi User1 cterm=None term=None ctermfg=232 ctermbg=202
"short name
hi User2 cterm=None term=None ctermfg=232 ctermbg=178
"modified flag
hi User3 cterm=None term=None ctermfg=white ctermbg=235
" BuffNum
hi User5 cterm=None term=None ctermfg=232 ctermbg=106
" user 4 and 6 are in all plug for ale and obsess
"}}
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
" load vimrc bindings{{
" nnoremap <leader>ev :vsp $MYVIMRC<CR>
" nnoremap <leader>ez :vsp ~/.zshrc<CR>
" nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>sv :source ~/.vimrc<CR>
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

nnoremap Y y$

" save session, open with vim -S
nnoremap <leader>S :mksession!<CR>
" save file
nnoremap <leader>w :w<CR>
nnoremap <leader>qb :bd!<CR>
nnoremap <leader>qq :qa!<CR>
nnoremap <leader>qt :tabc<CR>
nnoremap <leader>qw <C-w>c

nnoremap <leader>t1 1gt
nnoremap <leader>t2 2gt
nnoremap <leader>t3 3gt
nnoremap <leader>t4 4gt
nnoremap <leader>t5 5gt
nnoremap <leader>t6 6gt
nnoremap <leader>t7 7gt
nnoremap <leader>t8 8gt
nnoremap <leader>t9 9gt

nnoremap <leader>= <C-w>s
nnoremap <leader>\ <C-w>v

" edits
nnoremap <leader>et :e %<CR>
nnoremap <leader>ea :bufdo e<CR>

nnoremap <leader>ccr :Cargo run<CR>
nnoremap <leader>ccb :Cargo build<CR>
nnoremap <leader>cct :Cargo test<CR>
nnoremap <leader>cc :Cargo
nnoremap <leader>cm :make<CR>

" Moving buffer and tabs {{

" opens current window in new tab
nnoremap <leader>ot :tabedit %<CR>
nnoremap <leader>ob :ls<CR>:b
nnoremap <leader>on :tabnew<CR>

" Switch tab with lead m
nnoremap <leader>m gt
nnoremap <leader>M gT

" List buffers
nnoremap <leader>l :ls<CR>

nnoremap <leader>bm :bm<CR>
nnoremap <leader>bb :b#<CR>

" }}
" " gs sorts paragraph
" nnoremap gs gsip

" Alternates spellchecking
" Jump around with [s ]s, suggestions z=, zg add to spell file, zw remove from
" spell file, zug undo zw or zg
" nnoremap <leader>k :set spell!<CR>
" I used the unimpaired vim plugin, [os or ]os

" for incrementing numbers
nnoremap <leader>i <C-a>

" & runs previous substitution with previous flags, used when ammending sub
" command
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"Visual selection the X to search for that selection. not work with . and *
vmap / y/<C-R>"<CR>

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
set lazyredraw          "only redraws screen when we have to
filetype indent on " load filetype specific indent files
filetype plugin indent on
filetype plugin on
set encoding=utf-8
set nocompatible
set ignorecase
set hidden
set autoread

set undofile
set undodir="$VIMDATA/undo"

if !has('nvim')
    set undodir=~/.vim/undo
endif
augroup vimrc
    autocmd!
    autocmd BufWritePre /tmp/* setlocal noundofile
augroup END
" Might need to do this if it doesn't exist
" :call mkdir(&undodir, 'p')

" For pasting from system clipboard
set pastetoggle=<leader>tp
"
" fill search field with last search with <C-r>/

" redirect ex output to buffer? {{
" :redir @a    redirect output of following commands to register a
" :let         list every current option and its value
" G<CR>        go straight to the end of the listing and make it disappear
" :redir END   stop redirection
" :tabnew      open a new buffer in a new window in a new tab page
" ap          put from register a
" }}

" prefers current vim session if opening in the nvim terminal (command line/ commit message editting)
if has('nvim') && executable('nvr')
    let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif
" }}
" Filetype setters{{

" au filetype python setlocal mp=python3\ %
" au filetype java setlocal mp=javac\ %
" au filetype c setlocal mp=gcc\ -Werror\ -Wextra\ -Wall\ -ansi\ -pedantic-errors\ -g\ -lm\ %
" au filetype cpp setlocal mp=gcc\ -Werror\ -Wextra\ -Wall\ -ansi\ -pedantic-errors\ -g\ -lm\ %
" }}
