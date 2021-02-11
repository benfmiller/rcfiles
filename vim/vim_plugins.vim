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

if (g:use_coc == 1)
    " Use release branch (recommend)
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
" FZF {{
if (g:use_fzf == 1)
    nnoremap <leader>ff :FZF<CR>
else
    nnoremap <leader>ff :CtrlP<CR>
endif

if (g:use_rg == 1)
    nnoremap <leader>fg :Rg
else
    nnoremap <leader>fg :vimgrep
endif
"}}
" YCM {{
if (g:use_ycm == 1)
    let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
    " let g:ycm_server_keep_logfiles = 1
    " let g:ycm_server_log_level = 'debug'
endif
"}}
" COC {{
" Github Config {{

if (g:use_coc == 1)
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
let g:vimspector_enable_mappings = 'HUMAN'
" }}
" Plugin Maps{{
" toggle undotree
nnoremap <leader>tu :UndotreeToggle<CR>

nnoremap <leader>tm :MaximizerToggle<CR>

nnoremap <leader>to :Obsess!<CR>

vmap <C-m> :'<,'>Commentary<CR>
nnoremap <C-m> :Commentary<CR>

" open unimpaired vim info
nnoremap <leader>ou :e ~/.local/share/nvim/plugged/vim-unimpaired/doc/unimpaired.txt<CR>

" NERDtree
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

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
