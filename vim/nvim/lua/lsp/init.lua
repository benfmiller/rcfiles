-- -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
-- require("neodev").setup({
--     library = { plugins = { "nvim-dap-ui" }, types = true },
--     -- add any options here, or leave empty to use the default settings
-- })

-- Setup nvim-cmp.
local cmp = require 'cmp'

local lspkind = require('lspkind')
local formatting = {
    format = lspkind.cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        -- before = function (entry, vim_item)
        --   ...
        --   return vim_item
        -- end
    })
}

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
        ['<C-n>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
        { name = 'amazonq' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        { name = 'nvim_lsp_signature_help' }
    }, {
        { name = 'buffer' },
    }),
    experimental = {
        -- completion menu
        native_menu = false,

        -- ghost_text = true, -- in favor of Copilot
    },
    -- formatting = formatting
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

local home = os.getenv('HOME')
-- vim.lsp.set_log_level('debug')

if vim.g.use_q == 1 then
    require('amazonq').setup({
        -- https://code.amazon.com/packages/AmazonQNVim/trees/mainline
        -- ssoStartUrl = "https://view.awsapps.com/start",
        -- lsp_server_cmd = { 'node', home .. '/.local/share/nvim/plugged/' .. 'AmazonQNVim/language-server/build/aws-lsp-codewhisperer-token-binary.js', '--stdio' },
    })
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>',
    opts)
vim.api.nvim_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>',
    opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = require("lsp.defaults")["on_attach"]
local capabilities = require("lsp.defaults")["capabilities"]

-- require'lspconfig'.kotlin_language_server.setup {
-- on_attach = on_attach,
-- capabilities = capabilities,
-- root_dir = root_pattern("settings.gradle", ""),
-- flags = {
-- -- This will be the default in neovim 0.7+
-- debounce_text_changes = 150,
-- }
-- }
local servers = { 'pyright', 'rust_analyzer@nightly', 'gopls',
    'csharp_ls',                                                                     -- 'jdtls', -- 'vscode-java-test',
    'kotlin_language_server', 'bashls', 'yamlls', 'html', 'vimls', 'lua_ls',         -- 'sumneko_lua', -- 'java-debug',
    'cssls', 'jsonls', 'html', 'eslint', 'graphql', 'dockerls', 'texlab', 'clangd' } -- , 'solc'}
local serversNonMason = { 'terraform_lsp', 'solidity_ls' }
for _, lsp in pairs(serversNonMason) do
    vim.lsp.config('lspconfig', {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = { go = { workspaceSymbols = { enabled = true } } },
        flags = {
            -- -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    })
end
-- mason {{
require("mason").setup {
    ui = {
        icons = {
            package_installed = "✓"
        }
    }
}
require("mason-lspconfig").setup {
    ensure_installed = servers,
}

--Enable (broadcasting) snippet capability for completion
local capabilitiesHTML = vim.lsp.protocol.make_client_capabilities()
capabilitiesHTML.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('html', {
    on_attach = on_attach,
    capabilities = capabilitiesHTML,
})
-- require("mason-lspconfig").setup_handlers {
--     -- The first entry (without a key) will be the default handler
--     -- and will be called for each installed server that doesn't have
--     -- a dedicated handler.
--     function(server_name) -- default handler (optional)
--         vim.lsp.config(server_name, {
--             on_attach = on_attach,
--             capabilities = capabilities,
--             flags = {
--                 -- This will be the default in neovim 0.7+
--                 debounce_text_changes = 150,
--             }
--         })
--     end,
--     -- handler for specific servers
--     ["html"] = function()
--         vim.lsp.config("html", {
--             on_attach = on_attach,
--             capabilities = capabilitiesHTML,
--         })
--     end,
--     -- ["lua-ls"] = function()
--     --     require("lspconfig").lua_ls.setup {
--     --         on_attach = on_attach,
--     --         capabilities = capabilities,
--     --         settings = {
--     --
--     --             Lua = {
--     --                 completion = {
--     --                     callSnippet = "Replace"
--     --                 }
--     --             }
--     --         }
--     --     }
--     -- end
-- }
-- }}
local bufopts = { noremap = true, silent = true, buffer = bufnr }
function nnoremap(rhs, lhs, bufopts, desc)
    bufopts.desc = desc
    vim.keymap.set("n", rhs, lhs, bufopts)
end

function vnoremap(rhs, lhs, bufopts, desc)
    bufopts.desc = desc
    vim.keymap.set("v", rhs, lhs, bufopts)
end

nnoremap('<space>bf', vim.lsp.buf.format, bufopts, "Format file")
vnoremap('<space>bf', vim.lsp.buf.format, bufopts, "Format file")
vnoremap('bf', vim.lsp.buf.format, bufopts, "Format file")

require("symbols-outline").setup()
