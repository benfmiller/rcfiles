" Plugins{{
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - For Vim : '~/.vim/plugged'
" - Avoid using standard Vim directory names like 'plugin'
if (g:use_neovim == 1)
    call plug#begin(stdpath('data') . '/plugged')
else
    call plug#begin('~/.vim/plugged')
endif
"
" Require Installation{{
" Consider telescope???
if (g:use_ycm == 1)
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
endif

if (g:use_fzf == 1)
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
else
    " https://github.com/kien/ctrlp.vim
    Plug 'kien/ctrlp.vim'
endif

if (g:use_rg == 1)
    Plug 'jremmen/vim-ripgrep', { 'do': { -> ripgrep#install() } }
endif

" Requires nvim to be too new!
" Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
"}}

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Debugger
Plug 'puremourning/vimspector'

Plug 'jiangmiao/auto-pairs'
Plug 'szw/vim-maximizer'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
" docs at ~/.local/share/nvim/plugged/vim-unimpaired/doc/unimpaired.txt
Plug 'tpope/vim-obsession'
" https://github.com/tpope/vim-obsession
" Run :Obsess o start recording to file

" Better linter
Plug 'dense-analysis/ale'

Plug 'mbbill/undotree'

Plug 'preservim/nerdtree'

" git plugins
" https://www.chrisatmachine.com/Neovim/12-git-integration/ Got this from this
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
"
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
" Plugin settings and maps {{
" Install Plugins stuff{{
" YCM {{
if (g:use_ycm == 1)
    let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
    " let g:ycm_server_keep_logfiles = 1
    " let g:ycm_server_log_level = 'debug'
endif
"}}
if (g:use_fzf == 1)
    nnoremap <leader>f :FZF<CR>
else
    nnoremap <leader>f :CtrlP<CR>
endif
"}}
" Obsess {{
set statusline+=\ \|\ %4*%{ObsessionStatus(\"ObAct\",\"ObPaus\")}%*
" Obsess, moved to all plug
hi User4 cterm=None term=None ctermfg=232 ctermbg=6
" }}
" Ale {{
" Ale Maps{{
" ctrl e move to next error
nmap <silent> <C-e> <Plug>(ale_next_wrap)
nmap <silent> <C-l> <Plug>(ale_previous_wrap)
nnoremap <leader>ta :ALEToggle<CR>
" }}

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
set statusline+=\ %6*%{LinterStatus()}%*
" Ale color
hi User6 cterm=None term=None ctermfg=255 ctermbg=202


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
let g:ale_list_window_size = 4
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
nmap <leader>j <plug>(signify-next-hunk)
nmap <leader>k <plug>(signify-prev-hunk)
nmap <leader>J 9999<leader>gJ
nmap <leader>K 9999<leader>gk


" If you like colors instead
" highlight SignifySignAdd                  ctermbg=green
" guibg=#00ff00
" highlight SignifySignDelete ctermfg=black ctermbg=red    guifg=#ffffff
" guibg=#ff0000
" highlight SignifySignChange ctermfg=black ctermbg=yellow guifg=#000000
" guibg=#ffff00
"}}
" Easy Align{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Try gaip= or vipga=
" }}
" VimSpector {{
let g:vimspector_enable_mappings = 'HUMAN'
" }}
" Plugin Maps{{
" toggle undotree
nnoremap <leader>tu :UndotreeToggle<CR>

nnoremap <leader>tm :MaximizerToggle<CR>

nnoremap <leader>to :Obsess!<CR>

vmap <C-b> :'<,'>Commentary<CR>
nnoremap <C-b> :Commentary<CR>

" open unimpaired vim info
nnoremap <leader>ou :e ~/.local/share/nvim/plugged/vim-unimpaired/doc/unimpaired.txt<CR>

" NERDtree
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Git Stuff {{
" This comes from vim fugitive
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>ga :Git add
nnoremap <leader>gc :Git commit -m "
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gm :Git merge
nnoremap <leader>gos :Git log --stat<CR>
nnoremap <leader>goo :Git log --oneline<CR>

nnoremap <leader>gD :SignifyDiff<CR>
nnoremap <leader>gd :SignifyHunkDiff<CR>

nnoremap <leader>gv :GV<CR>
nnoremap <leader>gtv :GV!<CR>
"}}
"}}
" }}
