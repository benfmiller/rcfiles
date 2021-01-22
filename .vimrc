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
" Plugins{{
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - For Vim : '~/.vim/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

Plug 'ycm-core/YouCompleteMe'
" Plug 'git@github.com:ackyshake/VimeCompletesMe.git'
" Plug 'ackyshake/VimeCompletesMe'
"
" Synchronous
" Plug 'vim-syntastic/syntastic'
"
" "Asynchronous, requires makeprg
" Plug 'neomake/neomake'
"
" Better linter
 Plug 'dense-analysis/ale'

Plug 'mbbill/undotree'
Plug 'tpope/vim-unimpaired'
" docs at ~/.local/share/nvim/plugged/vim-unimpaired/doc/unimpaired.txt

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'preservim/nerdtree'

" git plugins
" https://www.chrisatmachine.com/Neovim/12-git-integration/ Got this from this
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
""
" Never seemed to work
" Plug 'junegunn/vim-github-dashboard'
" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plug 'sjl/gundo.vim' Couldn't get it to work

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Umanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
" Initialize plugin system
call plug#end()
"}}
" Plugin Settings{{
" Syntastic{{
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:ycm_show_diagnostics_ui = 0
" let g:syntastic_c_checkers = ['gcc', 'make']
" let g:syntastic_python_checkers = ['pylint']

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" }}
" Ale {{
" ctrl e move to next error
nmap <silent> <C-e> <Plug>(ale_next_wrap)
nmap <silent> <C-l> <Plug>(ale_previous_wrap)

" Adds number of errors to status line
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline+=%=
set statusline+=\ %{LinterStatus()}

let g:ale_completion_enabled = 1

" ALE Lint on text changed
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1

let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

" ALE Lint should delay a bit?
let g:ale_lint_delay = 2000

" Let ALE know to what Linter to use for various programming languages
let g:ale_linters = {'javascript': ['eslint'],
\ 'java': ['javac']
\ }
" 'python':['pylint']

"Path to Eclipse LSP for ALE
" let g:ale_java_eclipselsp_path = '/usr/share/java/jdtls'
" let g:ale_java_eclipselsp_executable = '/usr/bin/jdtls'
" let g:ale_java_eclipselsp_config_path = '$HOME/.jdtls'

" Use Quickfix List instead of LocList
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
let g:ale_list_window_size = 5
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace', 'uncrustify'],
\   'javascript': ['eslint'],
\   'python': ['pylint'],
\}
" }}
" Signify {{
" Change these if you want
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

" I find the numbers disctracting
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1


" Jump though hunks
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
nmap <leader>gJ 9999<leader>gJ
nmap <leader>gK 9999<leader>gk


" If you like colors instead
" highlight SignifySignAdd                  ctermbg=green
" guibg=#00ff00
" highlight SignifySignDelete ctermfg=black ctermbg=red    guifg=#ffffff
" guibg=#ff0000
" highlight SignifySignChange ctermfg=black ctermbg=yellow guifg=#000000
" guibg=#ffff00
"}}
" }}
" Easy Align{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Try gaip= or vipga=
" }}
" Noremaps{{

" folding text{{
set foldenable
set foldlevelstart=0   " open most folds by default
set foldnestmax=10      " 10 nested fold max
nnoremap <leader>z za
set foldmethod=marker
set foldmarker={{,}}
"}}
" Plugin Maps{{
" toggle undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Syntastic Check
" nnoremap <leader>c :SyntasticCheck<CR>
"
" Syntastic toggle
" nnoremap <leader>s :SyntasticToggleMode<CR>

" open unimpaired vim info
nnoremap <leader>ou :e ~/.local/share/nvim/plugged/vim-unimpaired/doc/unimpaired.txt<CR>

" NERDtree
nnoremap <leader>t :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
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
