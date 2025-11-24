-- set runtimepath^=~/.vim runtimepath+=~/.vim/after
-- let &packpath=&runtimepath
if vim.g.vscode then
    -- Then normal Neovim
    -- vim.cmd 'source ~/.vimrc'
    --
    -- require('lsp')
    -- require('misc')

    -- VSCode Neovim
    require('vscodeUser')
else
    -- Ordinary Neovim
    vim.cmd 'source ~/.vimrc'

    require('lsp')
    require('misc')
end
