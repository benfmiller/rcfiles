" Leader and mapleader{{
inoremap jk <ESC>
let mapleader = " "
"}}
" Visuals{{
set number
set relativenumber
color elflord
set showcmd             " show command in bottom bar
set wildmenu            "visual autocomplete for command menu
set laststatus=2  " always display the status line
autocmd InsertEnter,InsertLeave * set cul!
set showmatch           "highlight matching brackets [{()}]
syntax enable
set scrolloff=8
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

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

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

" Moves up line visually
nnoremap j gj
nnoremap k gk

" save session, open with vim -S
nnoremap <leader>s :mksession<CR>
"}}
