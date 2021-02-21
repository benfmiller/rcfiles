let g:use_coc=0
let g:use_ycm=0
let g:use_vimspector=0
"if zero, uses ctrlp instead
let g:use_fzf=0
let g:use_rg=0
let g:use_neovim=0
let g:on_windows=1
let g:use_md_viewer=0

let g:ale_completion_enabled = 0

source ~/rcfiles/vim/vim_plugins.vim

autocmd VimEnter * set vb t_vb=
" Make sure to remove annoying inoremaps for brackets for vscode
" Remove Obsession from statusline
" Can't source files for vscode
