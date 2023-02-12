-- set runtimepath^=~/.vim runtimepath+=~/.vim/after
-- let &packpath=&runtimepath
vim.cmd 'source ~/.vimrc'

require('lsp')
require('misc')
