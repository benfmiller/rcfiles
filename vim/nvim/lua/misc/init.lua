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
-- local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
-- for type, icon in pairs(signs) do
--     local hl = "LspDiagnosticsSign" .. type
--     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end
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

-- Dap UI {{
--
require("nvim-dap-virtual-text").setup()
require("dapui").setup()
vim.keymap.set('n', '<M-;>', '<cmd>lua require("dapui").toggle()<CR>',
    { noremap = true, silent = true, desc = "Toggle Dap UI" })

vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

vim.fn.sign_define('DapBreakpoint', { text = '•', texthl = 'blue', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', {
    text = '●',
    texthl = 'orange',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint'
})
vim.fn.sign_define('DapBreakpointRejected', {
    text = '●',
    texthl = 'blue',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint'
})
vim.fn.sign_define('DapStopped', { text = '•', texthl = 'green', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text = '•', texthl = 'yellow', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
-- }}

require("harpoon").setup({
    menu = {
        -- width = vim.api.nvim_win_get_width(0) // 2,
        width = 140,
        height = 25
    }
})

if vim.g.use_gpt == 1 then
    require("chatgpt").setup({
        keymaps = {
            submit = "<C-s>",
            cycle_windows = "<C-p",
            -- close = { "<C-c>" },
            -- submit = "<C-Enter>",
            -- yank_last = "<C-y>",
            -- yank_last_code = "<C-k>",
            -- scroll_up = "<C-u>",
            -- scroll_down = "<C-d>",
            -- toggle_settings = "<C-o>",
            -- new_session = "<C-n>",
            -- cycle_windows = "<Tab>",
            -- -- in the Sessions pane
            -- select_session = "<Space>",
            -- rename_session = "r",
            -- delete_session = "d",
            -- <C-i> [Edit Window] use response as input.
        }
    })
end

if vim.g.use_copilot == 1 then
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    vim.api.nvim_set_keymap("i", "<C-P>", 'copilot#Previous()', { silent = true, expr = true })
    vim.api.nvim_set_keymap("i", "<C-O>", 'copilot#Next()', { silent = true, expr = true })
end



-- Command to toggle inline diagnostics
vim.api.nvim_create_user_command(
    'DiagnosticsToggleVirtualText',
    function()
        local current_value = vim.diagnostic.config().virtual_text
        if current_value then
            vim.diagnostic.config({ virtual_text = false })
        else
            vim.diagnostic.config({ virtual_text = true })
        end
    end,
    {}
)

-- Command to toggle diagnostics
vim.api.nvim_create_user_command(
    'DiagnosticsToggle',
    function()
        local current_value = vim.diagnostic.is_disabled()
        if current_value then
            vim.diagnostic.enable()
        else
            vim.diagnostic.disable()
        end
    end,
    {}
)
