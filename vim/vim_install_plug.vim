" Plugins{{
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - For Vim : '~/.vim/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')
"
" Require Installation{{
" Consider telescope???
Plug 'jremmen/vim-ripgrep', { 'do': { -> ripgrep#install() } }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
"}}

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

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
" Install Plugins stuff{{
" YCM {{
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'
"}}
nnoremap <leader>f :FZF<CR>
"}}
source ~/rcfiles/vim/vim_all_plug.vim
