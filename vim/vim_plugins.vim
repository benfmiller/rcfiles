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
" Consider telescope???
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
else
    " https://github.com/kien/ctrlp.vim
    Plug 'kien/ctrlp.vim'
endif

if (g:use_md_viewer == 1)
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
endif

" Requires nvim to be too new!
" Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
"}}

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align

" Plug 'roxma/vim-tmux-clipboard'
" switched to tbone cause above was slowing deletes
Plug 'junegunn/vim-easy-align'
Plug 'morhetz/gruvbox'

" TODO More plugins to look into some time
" This might be fun at some time, requires google api key
" https://github.com/itchyny/calendar.vim
"
" shows hex colors, requries golang
" Plug 'RRethy/vim-hexokinase', {'do': 'make hexokinase'}
"
" This should be mostly implemented
" github.com/SirVer/ultisnips
" Consider this for code snipppets
" Plug 'SirVer/ultisnips'

" And this?
" https://github.com/honza/vim-snippets
"
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
Plug 'tpope/vim-commentary', {'on': 'Commentary'}
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
Plug 'junegunn/gv.vim'
"
Plug 'itchyny/vim-gitbranch'
" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

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
" hi Statusline cterm=NONE term=NONE ctermfg=232 ctermbg=191
" " Not Current
" hi StatuslineNC cterm=NONE term=NONE ctermfg=232 ctermbg=248
"Git
hi User1 cterm=None term=None ctermfg=232 ctermbg=202
"short name
hi User2 cterm=None term=None ctermfg=232 ctermbg=154
"modified flag
hi User3 cterm=None term=None ctermfg=white ctermbg=235
" BuffNum
hi User5 cterm=None term=None ctermfg=232 ctermbg=178
" user 4 and 6 are in all plug for ale and obsess
" }}
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

endif
"}}
" COC {{
" Github Config {{

if (g:use_coc == 1)

    " TODO lints at end of line
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
hi User4 cterm=None term=None ctermfg=232 ctermbg=6
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

let g:ale_sign_error = '☕'
let g:ale_sign_warning = '⛅'
"'●⊗⊕⌛⌦⌼☕⛔✍⚠₿⌚⏱♛♔⭐⛅'
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
\}
if ale#path#FindNearestFile(0, 'Cargo.toml') is# ''
  let g:ale_linters = {'rust': ['rustc']}
endif
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

    nmap <leader>drc <Plug>VimspectorRunToCursor
    nmap <C-b> <Plug>VimspectorToggleBreakpoint
    nmap <leader>db <Plug>VimspectorToggleConditionalBreakpoint
endif
" }}
" Plugin Maps{{
" toggle undotree
nnoremap <leader>tu :UndotreeToggle<CR>
nnoremap <leader>tm :MaximizerToggle<CR>
nnoremap <leader>th :HexokinaseToggle<CR>
nnoremap <leader>to :Obsess!<CR>
nnoremap <leader>tt :TagbarToggle<CR>

vmap <C-m> :'<,'>Commentary<CR>
nnoremap <C-m> :Commentary<CR>

" open unimpaired vim info
nnoremap <leader>ou :e ~/.local/share/nvim/plugged/vim-unimpaired/doc/unimpaired.txt<CR>

" NERDtree
" nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"
" nnoremap <C-f> :NERDTreeFind<CR>

au Filetype tex let b:AutoPairs = {"$":"$", "$$":"$$", '(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
au Filetype markdown let b:AutoPairs = {"*":"*", "**":"**", "$":"$", "$$":"$$", '(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

" Git Stuff {{
" This comes from vim fugitive
let g:git_messenger_no_default_mappings = 1

nnoremap <leader>gg :G<CR><C-w>10_
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gsb :Git status -sb<CR>
nnoremap <leader>ga :Git add
nnoremap <leader>gc :Git commit -m "
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gr :Git merge
nnoremap <leader>gos :Git log --stat<CR>
nnoremap <leader>goo :Git log --oneline<CR>

nnoremap <leader>gD :SignifyDiff<CR>
nnoremap <leader>gd :SignifyHunkDiff<CR>

nnoremap <leader>gm :GitMessenger<CR>

nnoremap <leader>gv :GV<CR>
nnoremap <leader>gtv :GV!<CR>
"}}
"}}
" FZF {{
if (g:use_fzf == 1)
    nnoremap <leader>ff :Files<CR>
    nnoremap <leader>fbb :Buffers<CR>
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
    nnoremap <leader>fll :Lines<CR>

    nnoremap <leader>fgf :GFiles<CR>
    nnoremap <leader>fgc :Commits<CR>
    nnoremap <leader>fgb :BCommits<CR>

    nnoremap <leader>fgs :GFiles?<CR>
    nnoremap <leader>gb :GBranches<CR>
else
    nnoremap <leader>ff :CtrlP<CR>
endif
"}}
" Grepper {{

nnoremap <leader>rr :GrepperGrep
nnoremap <leader>rg :Grepper<CR>

" Search for current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>
"
" Search for the current selection
nmap <leader>/ <plug>(GrepperOperator)
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
" }}
