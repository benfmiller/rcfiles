let g:use_coc=0
let g:use_ycm=1
"if zero, uses ctrlp instead
let g:use_fzf=1
let g:use_rg=1
let g:use_neovim=1
let g:on_windows=0
let g:use_md_viewer=1

let g:ale_completion_enabled = 0

source ~/rcfiles/vim/vim_plugins.vim

autocmd VimEnter * set vb t_vb=
" Make sure to remove annoying inoremaps for brackets for vscode
" Remove Obsession from statusline
" Can't source files for vscode
