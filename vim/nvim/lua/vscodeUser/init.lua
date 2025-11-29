-- general keymaps {{
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- yank to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', opts)

-- paste from system clipboard
keymap({ "n", "v" }, "<leader>p", '"+p', opts)

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- paste preserves primal yanked piece
keymap("v", "p", '"_dP', opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)


-- insert mode keymaps are not possible in vscode...
keymap("i", "jk", "<Esc>", opts)
keymap("t", "l;", "<C-\\><C-n>", opts)
keymap("c", "jk", "<C-f>", opts)

-- https://medium.com/@nikmas_dev/vscode-neovim-setup-keyboard-centric-powerful-reliable-clean-and-aesthetic-development-582d34297985



keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>qb", ":bd!<CR>", opts)


vim.o.cmdheight = 1

-- }}
-- call vscode commands from neovim {{
-- general keymaps
keymap({ "n", "v" }, "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
keymap({ "n", "v" }, "<leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
keymap({ "n", "v" }, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap({ "n", "v" }, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
keymap({ "n", "v" }, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
keymap({ "n", "v" }, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
keymap({ "n", "v" }, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
keymap({ "n", "v" }, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
keymap({ "n", "v" }, "<leader>pr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
keymap({ "n", "v" }, "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")

-- harpoon keymaps
keymap({ "n", "v" }, "<leader>ha", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
keymap({ "n", "v" }, "<leader>ho", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
keymap({ "n", "v" }, "<leader>he", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
keymap({ "n", "v" }, "<leader>h1", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
keymap({ "n", "v" }, "<leader>h2", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
keymap({ "n", "v" }, "<leader>h3", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
keymap({ "n", "v" }, "<leader>h4", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
keymap({ "n", "v" }, "<leader>h5", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
keymap({ "n", "v" }, "<leader>h6", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
keymap({ "n", "v" }, "<leader>h7", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
keymap({ "n", "v" }, "<leader>h8", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
keymap({ "n", "v" }, "<leader>h9", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")

-- project manager keymaps
keymap({ "n", "v" }, "<leader>pa", "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>")
keymap({ "n", "v" }, "<leader>po", "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>")
keymap({ "n", "v" }, "<leader>pe", "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>")



-- nnoremap <leader>yr <cmd>Telescope lsp_references<cr>
-- nnoremap <leader>ya <cmd>Telescope lsp_code_actions<cr>
-- nnoremap <leader>ybb <cmd>Telescope diagnostics bufnr=0<cr>
-- nnoremap <leader>yba <cmd>Telescope diagnostics<cr>
-- nnoremap <leader>yi <cmd>Telescope lsp_implementations<cr>
-- nnoremap <leader>yd <cmd>Telescope lsp_definitions<cr>
-- nnoremap <leader>yt <cmd>Telescope lsp_type_definitions<cr>
-- nnoremap <leader>yss <cmd>Telescope lsp_document_symbols<cr>
-- nnoremap <C-M-o> <cmd>Telescope lsp_document_symbols<cr>
-- nnoremap <leader>ysw <cmd>Telescope lsp_workspace_symbols<cr>
-- nnoremap <leader>ysd <cmd>Telescope lsp_dynamic_workspace_symbols<cr>

keymap({ "n", "v" }, "<leader>yd", "<cmd>lua require('vscode').action('editor.action.goToTypeDefinition')<CR>")
keymap({ "n", "v" }, "<leader>yi", "<cmd>lua require('vscode').action('editor.action.goToImplementations')<CR>")
keymap({ "n", "v" }, "<leader>yr", "<cmd>lua require('vscode').action('editor.action.goToReferences')<CR>")
keymap({ "n", "v" }, "<leader>j", "<cmd>lua require('vscode').action('workbench.action.editor.nextChange')<CR>")
keymap({ "n", "v" }, "<leader>k", "<cmd>lua require('vscode').action('workbench.action.editor.previousChange')<CR>")
-- }}
