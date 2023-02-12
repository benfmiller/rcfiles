local bufopts = { noremap = true, silent = true }

-- Trouble {{
-- https://github.com/folke/todo-comments.nvim
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
-- }}

-- git-worktree {{

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

vim.keymap.set("n", "<leader>gws", ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", bufopts)
vim.keymap.set("n", "<leader>gwa", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", bufopts)
-- <Enter> - switches to that worktree
-- <c-d> - deletes that worktree
-- <c-f> - toggles forcing of the next deletion
--  }}

-- Treesitter {{
-- https://github.com/nvim-treesitter/nvim-treesitter
require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    playground = {
        enable = true,
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
    },
}
-- }}

-- Devicons {{

require 'nvim-web-devicons'.setup {
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
    },
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true,
}
-- }}

vim.cmd([[
autocmd BufWritePre * silent! lua vim.lsp.buf.format()
]])
