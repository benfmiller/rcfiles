" Plugins{{
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - For Vim : '~/.vim/plugged'
" - For Windows: use same as unix vim for vim plug and vimfiles for plugins
" - Avoid using standard Vim directory names like 'plugin'
"

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

if (g:on_windows == 0)
    if (g:use_neovim == 1)
        let g:plug_path=stdpath('data')
    else
        let g:plug_path='~/.vim'
    endif
    " Install vim-plug if not found
    if empty(glob(g:plug_path . '/autoload/plug.vim'))
      silent !curl -fLo (g:plug_path . '/autoload/plug.vim') --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
else
    let g:plug_path='~/vimfiles'
endif

call plug#begin(g:plug_path . '/plugged')
"
" Check vimrc variables{{
if (g:use_ycm == 1)
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --rust-completer' }
endif

if (g:use_coc == 1)
    " Use release branch (recommend)
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

if (g:use_vimspector == 1)
    " Debugger
    Plug 'puremourning/vimspector'
endif

if (g:use_fzf == 1)
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'stsewd/fzf-checkout.vim'
    Plug 'gfanto/fzf-lsp.nvim'
elseif (g:use_ctrlp == 1)
    " https://github.com/kien/ctrlp.vim
    Plug 'kien/ctrlp.vim'
elseif (g:use_telescope == 1)
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    Plug 'nvim-telescope/telescope-rg.nvim'
    Plug 'ThePrimeagen/git-worktree.nvim'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim', {'on': 'Lines'}
endif

if (g:use_md_viewer == 1)
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
endif


if (g:use_neovim == 1)
    Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
    Plug 'ThePrimeagen/harpoon'
    "
    " Neovim Tree sitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'

    Plug 'numToStr/Comment.nvim'

    Plug 'folke/todo-comments.nvim'
    Plug 'folke/lsp-colors.nvim'
    Plug 'folke/trouble.nvim'
else
    Plug 'tpope/vim-commentary', {'on': 'Commentary'}
endif

if (g:use_cmp == 1)
    " Plebvim lsp Plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/lsp-status.nvim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
    Plug 'onsails/lspkind-nvim'
    " Still in testing phase, requires :Copilot setup, which authenticates to waitlist
    " Plug 'github/copilot.vim'
    Plug 'nvim-lua/lsp_extensions.nvim'
    "
    " Plug 'nvim-lua/completion-nvim'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'simrat39/symbols-outline.nvim'
    " Plug 'tjdevries/nlua.nvim'
    " Plug 'tjdevries/lsp_extensions.nvim'
endif

if (g:use_devicons == 1)
    Plug 'kyazdani42/nvim-web-devicons'
endif
"}}

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align

" Plug 'roxma/vim-tmux-clipboard'
" switched to tbone cause above was slowing deletes
Plug 'junegunn/vim-easy-align'
Plug 'morhetz/gruvbox'
" Plug 'npxbr/gruvbox.nvim'

" TODO: More plugins to look into some time
" This might be fun at some time, requires google api key
" https://github.com/itchyny/calendar.vim
"
" shows hex colors, requries golang
" Plug 'RRethy/vim-hexokinase', {'do': 'make hexokinase'}
"
"
"
Plug 'hashivim/vim-terraform', {'for': 'terraform'}
Plug 'juliosueiras/vim-terraform-completion', {'for': 'terraform'}
Plug 'vim-syntastic/syntastic'

Plug 'udalov/kotlin-vim', {'for': 'kotlin'}
"

Plug 'vim-utils/vim-man'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'mhinz/vim-grepper'
Plug 'vim-test/vim-test'
Plug 'preservim/tagbar' " requires sinstal exuberant-ctags
Plug 'lervag/vimtex'

Plug 'jiangmiao/auto-pairs'
Plug 'szw/vim-maximizer', {'on':'MaximizerToggle'}
Plug 'christoomey/vim-tmux-navigator'

Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-tbone'
" docs at ~/.local/share/nvim/plugged/vim-unimpaired/doc/unimpaired.txt
Plug 'tpope/vim-obsession'
" https://github.com/tpope/vim-obsession
" Run :Obsess o start recording to file

" Better linter
Plug 'dense-analysis/ale'

" git plugins
" https://www.chrisatmachine.com/Neovim/12-git-integration/ Got some of this from this
Plug 'rhysd/git-messenger.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim', {'on': 'GV'}
"
" Using vim-fugitive status line now
" Plug 'itchyny/vim-gitbranch'
" Multiple Plug commands can be written in a single line using | separators
if (g:on_windows == 0)
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' | Plug 'quangnguyen30192/cmp-nvim-ultisnips'
endif

" On-demand loading
" au filetype python Plug 'timonv/vim-cargo'
" Plug 'timonv/vim-cargo', {'for': 'rust'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
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
" Setting Gruvbox {{
color gruvbox
set bg=dark
"
"https://www.ditig.com/256-colors-cheat-sheet
" hi Statusline cterm=NONE term=NONE ctermfg=232 ctermbg=191
" " Not Current
" hi StatuslineNC cterm=NONE term=NONE ctermfg=232 ctermbg=248
"Git
hi User1 cterm=None term=None ctermfg=232 ctermbg=202 guifg=#080808 guibg=#ff5f00
"short name
hi User2 cterm=None term=None ctermfg=232 ctermbg=154 guifg=#080808 guibg=#afff00
"modified flag
hi User3 cterm=None term=None ctermfg=white ctermbg=235 guifg=#ffffff guibg=#262626
" BuffNum
hi User5 cterm=None term=None ctermfg=232 ctermbg=178 guifg=#080808 guibg=#d7af00
" user 4 and 6 are in all plug for ale and obsess
"
highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE

" For Lsp signature highlight
hi! link LspSignatureActiveParameter Search
"}}
" Plugin settings and maps {{
" YCM {{
if (g:use_ycm == 1)
    let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
    " let g:ycm_server_keep_logfiles = 1
    " let g:ycm_server_log_level = 'debug'
    "
    nnoremap <leader>yd :YcmCompleter GetDoc<CR>
    nnoremap <leader>yt :YcmCompleter GetType<CR>
    nnoremap <leader>yg :YcmCompleter GoTo
    nnoremap <leader>yr :YcmCompleter RefactorRename
    nmap <leader>yh <plug>(YCMHover)
    let g:ycm_filetype_blacklist = {}

endif
"}}
" COC {{
" Github Config {{

if (g:use_coc == 1)

    " lints at end of line
    let g:Coc_virtualText = 1


    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Give more space for displaying messages.
    set cmdheight=2

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    if has("patch-8.1.1564")
      " Recently vim can merge signcolumn and number column into one
      set signcolumn=number
    else
      set signcolumn=yes
    endif

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-space> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Make <CR> auto-select the first completion item and notify coc.nvim to
    " format on enter, <cr> could be remapped by other vim plugin
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
      endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    " xmap <leader>f  <Plug>(coc-format-selected)
    " nmap <leader>f  <Plug>(coc-format-selected)
    xmap <leader>fm  <Plug>(coc-format-selected)
    nmap <leader>fm  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of language server.
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <space>od  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <space>ss  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent><nowait> <space>J  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent><nowait> <space>K  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


    nnoremap <leader>tce :CocEnable<CR>
    nnoremap <leader>tcd :CocDisable<CR>
endif
" }}
" }}
" Obsess {{
set statusline+=\ \|\ %4*%{ObsessionStatus(\"ObAct\",\"ObPaus\")}%*
" Obsess, moved to all plug
hi User4 cterm=None term=None ctermfg=232 ctermbg=6 guifg=#080808 guibg=#008080
" }}
" Ale {{
" Ale Maps{{
" ctrl e move to next error
nmap <silent> <C-e> <Plug>(ale_next_wrap)
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nnoremap <leader>ta :ALEToggle<CR>
" }}

" Adds number of errors to status line
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
" moved this addition to end of this file


" ALE Lint on text changed
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1

let g:ale_sign_error = '🌋'
let g:ale_sign_warning = '⛅'
"'●⊗⊕⌛⌦⌼☕⛔✍⚠₿⌚⏱♛♔⭐⛅🌋'
" ALE Lint should delay a bit?
" let g:ale_lint_delay = 2000

" Let ALE know to what Linter to use for various programming languages
" uses all available if not specified
" let g:ale_linters = {'javascript': ['eslint'],
" \ 'java': ['javac'],
" \ }
" \ 'python3':['pylint']

"Path to Eclipse LSP for ALE
" let g:ale_java_eclipselsp_path = '/usr/share/java/jdtls'
" let g:ale_java_eclipselsp_executable = '/usr/bin/jdtls'
" let g:ale_java_eclipselsp_config_path = '$HOME/.jdtls'
"
" Mappings in the style of unimpaired-next
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

" Use Quickfix List instead of LocList
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
let g:ale_list_window_size = 4
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace', 'uncrustify'],
\   'javascript': ['eslint'],
\   'python': ['black', 'autoimport', 'isort', 'autoimport'],
\   'rust': ['rustfmt'],
\   'terraform' : ['terraform'],
\   'go': ['gofmt','gofumpt','goimports','golines','remove_trailing_lines','trim_whitespace'],
\}
if ale#path#FindNearestFile(0, 'Cargo.toml') is# ''
  let g:ale_linters = {'rust': ['rustc']}
endif
let g:ale_enabled = 0

" let g:ale_linters = {
" \   'rust': ['cargo', 'rls', 'rustc', 'analyzer'],
" \}
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
" nmap <leader>J 9999<leader>gJ
" nmap <leader>K 9999<leader>gk


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
if (g:use_vimspector == 1)
    let g:vimspector_enable_mappings = 'HUMAN'
    let g:vimspector_base_dir=expand( '$HOME/.vim/vimspector-config' )
    nnoremap <leader>qd :VimspectorReset<CR>
    nnoremap <leader>dd :call vimspector#Continue()<CR>
    nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
    nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
    nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
    nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
    nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
    nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>

    nmap <leader>dl <Plug>VimspectorStepInto
    nmap <leader>dj <Plug>VimspectorStepOver
    nmap <leader>dk <Plug>VimspectorStepOut
    nmap <leader>dR <Plug>VimspectorRestart
    nmap <leader>daw <Plug>VimspectorAddWatch
    nmap <leader>dew <Plug>VimspectorDeleteWatch

    " alt maps
    nmap <M-q> :VimspectorReset<CR>
    nmap <M-d> :call vimspector#Continue()<CR>
    nmap <M-l> <Plug>VimspectorStepInto
    nmap <M-j> <Plug>VimspectorStepOver
    nmap <M-k> <Plug>VimspectorStepOut
    nmap <M-h> <Plug>VimspectorRestart
    nmap <M-c> <Plug>VimspectorRunToCursor

    nmap <leader>drc <Plug>VimspectorRunToCursor
    nmap <C-b> <Plug>VimspectorToggleBreakpoint
    nmap <leader>db <Plug>VimspectorToggleConditionalBreakpoint
endif
" }}
" FZF | telescope {{
if (g:use_fzf == 1)
    nnoremap <leader>ff :Files<CR>
    nnoremap <leader>fr :Rg<CR>
    nnoremap <leader>fbb :Buffers<CR>
    nnoremap <leader>fb :Buffers<CR>
    nnoremap <leader>fo :Colors<CR>
    nnoremap <leader>fc :Commands<CR>
    nnoremap <leader>fm :Maps<CR>
    nnoremap <leader>fa :Marks<CR>
    nnoremap <leader>fw :Windows<CR>
    nnoremap <leader>ft :Helptags<CR>
    nnoremap <leader>fhc :History:<CR>
    nnoremap <leader>fhf :History<CR>
    nnoremap <leader>fhs :History/<CR>
    nnoremap <leader>flb :BLines<CR>

    nnoremap <leader>? :BLines<CR>
    nnoremap <leader>/ :Lines<CR>

    nnoremap <leader>fgf :GFiles<CR>
    nnoremap <leader>F :GFiles<CR>
    nnoremap <leader>fgc :Commits<CR>
    nnoremap <leader>fgb :BCommits<CR>

    nnoremap <leader>fgs :GFiles?<CR>
    nnoremap <leader>gb :GBranches<CR>
elseif (g:use_ctrlp == 1)
    nnoremap <leader>ff :CtrlP<CR>
elseif (g:use_telescope == 1)
    " Find files using Telescope command-line sugar.
    nnoremap <leader>F <cmd>Telescope find_files<cr>
    nnoremap <leader>ff <cmd>Telescope git_files<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    nnoremap <leader>fhh <cmd>Telescope help_tags<cr>

    nnoremap <leader>fr <cmd>lua require("telescope").extensions.live_grep_raw.live_grep_raw()<cr>
    nnoremap <leader>fbb <cmd>Telescope buffers<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fo <cmd>Telescope colorscheme<cr>
    nnoremap <leader>fc <cmd>Telescope commands<cr>
    nnoremap <leader>fhc <cmd>Telescope command_history<cr>
    nnoremap <leader>fhs <cmd>Telescope search_history<cr>
    nnoremap <leader>fm <cmd>Telescope keymaps<cr>
    nnoremap <leader>fa <cmd>Telescope marks<cr>
    nnoremap <leader>fty <cmd>Telescope filetypes<cr>

    nnoremap <leader>flb <cmd>Telescope current_buffer_fuzzy_find<cr>
    nnoremap <leader>/ <cmd>Telescope current_buffer_fuzzy_find<cr>
    " nnoremap <leader>? <cmd>Telescope live_grep<cr>
    " nnoremap <leader>? <cmd>lua require("telescope.builtin").live_grep({ sorter = require('telescope.sorters').get_generic_fuzzy_sorter({})})<cr>
    nnoremap <leader>? :Lines<CR>

    nnoremap <leader>fgc <cmd>Telescope git_commits<cr>
    nnoremap <leader>fgb <cmd>Telescope git_bcommits<cr>

    nnoremap <leader>fgss <cmd>Telescope git_status<cr>
    nnoremap <leader>fgst <cmd>Telescope git_stash<cr>
    nnoremap <leader>gb <cmd>Telescope git_branches<cr>

    nnoremap <leader>fp <cmd>Telescope planets<cr>

    nnoremap <leader>fts <cmd>Telescope treesitter<cr>
    nmap <C-M-p> <cmd>Telescope treesitter<cr>

    nnoremap <leader>yr <cmd>Telescope lsp_references<cr>
    nnoremap <leader>ya <cmd>Telescope lsp_code_actions<cr>
    nnoremap <leader>ybb <cmd>Telescope diagnostics bufnr=0<cr>
    nnoremap <leader>yba <cmd>Telescope diagnostics<cr>
    nnoremap <leader>yi <cmd>Telescope lsp_implementations<cr>
    nnoremap <leader>yd <cmd>Telescope lsp_definitions<cr>
    nnoremap <leader>yt <cmd>Telescope lsp_type_definitions<cr>
    nnoremap <leader>yss <cmd>Telescope lsp_document_symbols<cr>
    nnoremap <C-M-o> <cmd>Telescope lsp_document_symbols<cr>
    nnoremap <leader>ysw <cmd>Telescope lsp_workspace_symbols<cr>
    nnoremap <leader>ysd <cmd>Telescope lsp_dynamic_workspace_symbols<cr>

    nnoremap <leader>fd <cmd>TodoTelescope<cr>

    " Using Lua functions
    " nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
    " nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
    " nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
    " nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
lua << EOF
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
local actions = require("telescope.actions")
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
        ["<C-M-q>"] = actions.send_to_qflist + actions.open_qflist,
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
        hidden = true,
        no_ignore = true

    }
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
EOF
endif
"}}
" Grepper {{

nnoremap <leader>rr :GrepperGrep
nnoremap <leader>rg :Grepper<CR>

" Search for current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>
"
" Search for the current selection
" nmap <leader>/ <plug>(GrepperOperator)
xmap <leader>/ <plug>(GrepperOperator)

if (g:use_rg == 1)
    let g:grepper = {}
    let g:grepper.tools = ['grep', 'git', 'rg']

    set grepprg=rg\ -H\ --no-heading\ --vimgrep
    set grepformat=$f:$l:%c:%m

else
    let g:grepper = {}
    let g:grepper.tools = ['grep', 'git']
endif

" expands grep to GrepperGrep in command line
function! SetupCommandAlias(input, output)
    exec 'cabbrev <expr> '.a:input .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")' .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction
call SetupCommandAlias("grep", "GrepperGrep")

" If you really want to run the :grep command, use <C-v><Space> to prevent the expansion.

" }}
" {{ UltiSnips

" let g:UltiSnipsExpandTrigger = '<nop>'
let g:UltiSnipsExpandTrigger = '<C-space>'
let g:UltiSnipsJumpForwardTrigger = '<C-m>'
let g:UltiSnipsJumpBackwardTrigger = '<C-b>'
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsSnippetDirectories = ["~/rcfiles/UltiSnips"]

nnoremap <leader>es :UltiSnipsEdit!<cr>

" }}
" Vim-Test {{
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "dispatch"

" let test#python#runner = 'pytest'
" }}
" terraform and syntastic {{
" Minimal Configuration
" set nocompatible
" syntax on
" filetype plugin indent on


" Syntastic Config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = {'mode':'passive'}

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 0

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0

" Syntastic {{
nnoremap <leader>ts :SyntasticToggleMode<CR>
" see :h syntastic-loclist-callback
if (g:use_neovim == 1)
function! SyntasticCheckHook(errors)
    if !empty(a:errors)
        let g:syntastic_loc_list_height = min([len(a:errors), 4])
        call cheat#providers#syntastic#Hook(a:errors)
    endif
endfunction
endif

" let g:syntastic_warning_symbol = '⛅'
" let g:syntastic_error_symbol= '🌋'
"'●⊗⊕⌛⌦⌼☕⛔✍⚠₿⌚⏱♛♔⭐⛅🌋'
" }}
" }}
" harpoon {{
nnoremap <leader>ha :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>hh :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <leader>h1 :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <leader>h2 :lua require("harpoon.term").gotoTerminal(2)<CR>
nnoremap <leader>h3 :lua require("harpoon.term").gotoTerminal(3)<CR>
nnoremap <leader>h4 :lua require("harpoon.term").gotoTerminal(4)<CR>
nnoremap <leader>h5 :lua require("harpoon.term").gotoTerminal(5)<CR>
nnoremap <leader>h6 :lua require("harpoon.term").gotoTerminal(6)<CR>
nnoremap <leader>h7 :lua require("harpoon.term").gotoTerminal(7)<CR>
nnoremap <leader>h8 :lua require("harpoon.term").gotoTerminal(8)<CR>
nnoremap <leader>h9 :lua require("harpoon.term").gotoTerminal(9)<CR>

nnoremap <leader>ht1 :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <leader>ht2 :lua require("harpoon.term").gotoTerminal(2)<CR>
nnoremap <leader>ht3 :lua require("harpoon.term").gotoTerminal(3)<CR>
nnoremap <leader>ht4 :lua require("harpoon.term").gotoTerminal(4)<CR>
nnoremap <leader>ht5 :lua require("harpoon.term").gotoTerminal(5)<CR>
nnoremap <leader>ht6 :lua require("harpoon.term").gotoTerminal(6)<CR>
nnoremap <leader>ht7 :lua require("harpoon.term").gotoTerminal(7)<CR>
nnoremap <leader>ht8 :lua require("harpoon.term").gotoTerminal(8)<CR>
nnoremap <leader>ht9 :lua require("harpoon.term").gotoTerminal(9)<CR>

nnoremap <leader>hl :lua require("harpoon.ui").nav_next()<CR>
nnoremap <leader>hk :lua require("harpoon.ui").nav_prev()<CR>

nnoremap <leader>H1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>H2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>H3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>H4 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>H5 :lua require("harpoon.ui").nav_file(5)<CR>
nnoremap <leader>H6 :lua require("harpoon.ui").nav_file(6)<CR>
nnoremap <leader>H7 :lua require("harpoon.ui").nav_file(7)<CR>
nnoremap <leader>H8 :lua require("harpoon.ui").nav_file(8)<CR>
nnoremap <leader>H9 :lua require("harpoon.ui").nav_file(9)<CR>

nnoremap <leader>hf1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>hf2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>hf3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>hf4 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>hf5 :lua require("harpoon.ui").nav_file(5)<CR>
nnoremap <leader>hf6 :lua require("harpoon.ui").nav_file(6)<CR>
nnoremap <leader>hf7 :lua require("harpoon.ui").nav_file(7)<CR>
nnoremap <leader>hf8 :lua require("harpoon.ui").nav_file(8)<CR>
nnoremap <leader>hf9 :lua require("harpoon.ui").nav_file(9)<CR>

" }}
" NERDtree {{
" nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"
" nnoremap <C-f> :NERDTreeFind<CR>
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber
" }}
" Plugin Maps{{
" toggle undotree
nnoremap <leader>tu :UndotreeToggle<CR>

nnoremap <leader>tm :MaximizerToggle<CR>
nnoremap <M-m> :MaximizerToggle<CR>
inoremap <M-m> <C-[>:MaximizerToggle<CR>a

nnoremap <leader>th :HexokinaseToggle<CR>
nnoremap <leader>to :Obsess!<CR>
nnoremap <leader>tt :TagbarToggle<CR>

if (g:use_neovim == 1)
    lua require('Comment').setup()
    vmap gm <Plug>(comment_toggle_linewise_visual)
    nmap gm <Plug>(comment_toggle_current_linewise)
else
    vmap gm <cmd>'<,'>Commentary<CR>
    nnoremap gm <cmd>Commentary<CR>
endif
"
" open unimpaired vim info
nnoremap <leader>ou :e ~/.local/share/nvim/plugged/vim-unimpaired/doc/unimpaired.txt<CR>

au Filetype tex let b:AutoPairs = {"$":"$", "$$":"$$", '(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
au Filetype markdown let b:AutoPairs = {"*":"*", "**":"**", "$":"$", "$$":"$$", '(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}


augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

if (g:on_windows == 0)
autocmd BufWritePost *.snippets :CmpUltisnipsReloadSnippets
endif

nnoremap <leader>xx <cmd>TroubleToggle<cr><C-w>5_<cmd>set cmdheight=2<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr><C-w>5_<cmd>set cmdheight=2<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr><C-w>5_<cmd>set cmdheight=2<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr><C-w>5_<cmd>set cmdheight=2<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr><C-w>5_<cmd>set cmdheight=2<cr>
nnoremap <leader>xt <cmd>TodoTrouble<cr><C-w>5_<cmd>set cmdheight=2<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

nnoremap <leader>xa <cmd>TodoQuickFix<cr>
" Git Stuff {{
" This comes from vim fugitive
let g:git_messenger_no_default_mappings = 1

nnoremap <leader>gg :G<CR><C-w>10_
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gsb :Git status -sb<CR>
nnoremap <leader>ga :Git add
nnoremap <leader>gcm :Git commit -m "
nnoremap <leader>gcc :Git commit<cr>
nnoremap <leader>gca :Git commit --amend
nnoremap <leader>gpp :Git push<CR>
nnoremap <leader>gpf :Git push -f<CR>
nnoremap <leader>gpu :!git push --set-upstream origin `git branch --show-current`<CR>
nnoremap <leader>grttt :Git restore %<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>grl :Git remote update origin --prune<CR>
nnoremap <leader>grm :Git merge
nnoremap <leader>gos :Git log --stat<CR>
nnoremap <leader>goo :Git log --oneline<CR>

nnoremap <leader>grth <cmd>SignifyHunkUndo<CR>
nnoremap <leader>gD :SignifyDiff<CR>
nnoremap <leader>gd :SignifyHunkDiff<CR>

nnoremap <leader>gm :GitMessenger<CR>

nnoremap <leader>gv :GV<CR>
nnoremap <leader>gtv :GV!<CR>

nnoremap <leader>gi. .checkout<cr>

nnoremap <leader>gri :Git rebase -i
nnoremap <leader>grc :Git rebase --continue<cr>
nnoremap <leader>gre :Git rebase --edit-todo
nnoremap <leader>gra :Git rebase --abort

" https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History
nnoremap <leader>grff <cmd>Git reflog<cr>
nnoremap <leader>grfl <cmd>Git log -g<cr>
nnoremap <leader>grfo <cmd>Git log  --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short -g<cr>
nnoremap <leader>grb :Git branch recover-branch
nnoremap <leader>grbf yiw:Git branch recover-branch <C-r>"

nnoremap <leader>gic <cmd>Git count-objects -v<cr>

"}}
"}}
" }}
" Lua! {{
if (g:use_neovim == 1)
" git-worktree {{

if (g:use_telescope == 1)
lua <<EOF
-- https://github.com/ThePrimeagen/git-worktree.nvim

require("telescope").load_extension("git_worktree")

require("git-worktree").setup({
    --change_directory_command = <str> -- default: "cd",
    --update_on_change = <boolean> -- default: true,
    --update_on_change_command = <str> -- default: "e .",
    --clearjumps_on_change = <boolean> -- default: true,
    autopush = true -- default: false,
})

local Worktree = require("git-worktree")

-- op = Operations.Switch, Operations.Create, Operations.Delete
-- metadata = table of useful values (structure dependent on op)
--      Switch
--          path = path you switched to
--          prev_path = previous worktree path
--      Create
--          path = path where worktree created
--          branch = branch name
--          upstream = upstream remote name
--      Delete
--          path = path where worktree deleted

Worktree.on_tree_change(function(op, metadata)
  if op == Worktree.Operations.Switch then
    print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
  end
end)

EOF

nnoremap <leader>gws :lua require('telescope').extensions.git_worktree.git_worktrees()<cr>
nnoremap <leader>gwa :lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>
" -- <Enter> - switches to that worktree
" -- <c-d> - deletes that worktree
" -- <c-f> - toggles forcing of the next deletion
endif
" }}
" Trouble {{
"https://github.com/folke/todo-comments.nvim
"
lua << EOF
require("trouble").setup {
-- your configuration comes here
-- or leave it empty to use the default settings
-- refer to the configuration section below
}
require("todo-comments").setup {
-- your configuration comes here
-- or leave it empty to use the default settings
-- refer to the configuration section below
}
require("lsp-colors").setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
})
EOF
" }}
" Devicons {{
"
if (g:use_devicons == 1)
lua << EOF
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
EOF
endif
" }}
" nvim-cmp {{
set completeopt=menu,menuone,noselect

if (g:use_cmp == 1)

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<tab>'] = cmp.mapping.select_next_item(),
      ['<S-tab>'] = cmp.mapping.select_prev_item(),
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'path' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    }),
experimental = {
    -- completion menu
    native_menu = false,

    ghost_text = true,
},
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    mapping = {
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    },
  })

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>', opts)
vim.api.nvim_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

--let g:ale_sign_error = '🌋'
--let g:ale_sign_warning = '⛅'
--'●⊗⊕⌛⌦⌼☕⛔✍⚠₿⌚⏱♛♔⭐⛅🌋'
local lsp_status = require('lsp-status')
lsp_status.config{
  indicator_errors = '🌋',
  indicator_warnings = '⛅',
  indicator_info = '🍸',
  indicator_hint = '🦉',
  indicator_ok = '👌',
  status_symbol = '',
  update_interval = 2
}
-- lsp_status.register_progress()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  lsp_status.on_attach(client)
  require "lsp_signature".on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded" -- double, rounded, single, shadow, none
      },
      -- hi_parameter = "IncSearch",
      -- fix_pos = false,
      hi_parameter = "LspSignatureActiveParameter",
      floating_window=true,
      doc_lines=10,
      hint_enable = true,
      hint_prefix = "🦊 ",
      max_width = 100,
      toggle_key = '<C-l>',
    }, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
-- require'lspconfig'.kotlin_language_server.setup {
    -- on_attach = on_attach,
    -- capabilities = capabilities,
    -- root_dir = root_pattern("settings.gradle", ""),
    -- flags = {
      -- -- This will be the default in neovim 0.7+
      -- debounce_text_changes = 150,
    -- }
-- }
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'gopls', 'java_language_server',
    'kotlin_language_server', 'bashls', 'terraform_lsp', 'yamlls', 'html', 'vimls', 'sumneko_lua',
    'cssls', 'jsonls', 'html', 'eslint', 'graphql', 'dockerls', 'texlab'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
EOF

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return ''
endfunction

" status color
hi User6 cterm=None term=None ctermfg=255 ctermbg=202 guibg=#a26154
set statusline+=%=
set statusline+=\ %6*%{LspStatus()}%*
endif
" }}
endif
" }}
" Ale statusline {{
" set statusline+=%=
set statusline+=\ %6*%{LinterStatus()}%*
" }}
