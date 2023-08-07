-- with mason, install jdtls, java-test, java-debug-adapter
-- cp -r jdtls from .local/share/nvim/mason/share/jdtls to .local/share
-- uninstall jdtls from mason so that we don't get two lsp's attaching
-- mason jdtls also installs lombok
-- nvim-dap {{
-- Getting pytest results into nvim quickfix list
-- https://dhruvs.space/posts/pytest-quickfix-list/
--
-- Adapter list, vscode
-- https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
--
-- https://davelage.com/posts/nvim-dap-getting-started/
-- Some additional stuff
--
-- https://alpha2phi.medium.com/neovim-lsp-and-dap-using-lua-3fb24610ac9f
-- }}
--
local home = os.getenv('HOME')
local jdtls = require('jdtls')

-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = { 'gradlew', 'mvnw', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
-- no need to install anything here
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local bufopts = { noremap = true, silent = true, buffer = bufnr }
-- Helper function for creating keymaps
function nnoremap(rhs, lhs, bufopts, desc)
    bufopts.desc = desc
    vim.keymap.set("n", rhs, lhs, bufopts)
end

local bundles = {
    vim.fn.glob(home ..
        '/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'),
}
vim.list_extend(bundles,
    vim.split(vim.fn.glob(home .. '/.local/share/nvim/mason/packages/java-test/extension/server/*.jar'), "\n"))

local ws_folders_jdtls = {}
if root_dir then
    local file = io.open(root_dir .. "/../../.bemol/ws_root_folders")
    if file then
        -- echo "sup"
        for line in file:lines() do
            table.insert(ws_folders_jdtls, "file://" .. line)
        end
        file:close()
    end
end

-- could call normally after opening nvim??? don't really need this at the moment
-- language independent, just adds multiple checked out directories to lsp
function bemol()
    local bemol_dir = vim.fs.find({ '.bemol' }, { upward = true, type = 'directory' })[1]
    local ws_folders_lsp = {}
    if bemol_dir then
        local file = io.open(bemol_dir .. '/ws_root_folders', 'r')
        if file then
            for line in file:lines() do
                table.insert(ws_folders_lsp, line)
            end
            file:close()
        end
    end

    for _, line in ipairs(ws_folders_lsp) do
        vim.lsp.buf.add_workspace_folder(line)
    end
end

-- Copied from lsp.defaults
local lsp_status = require('lsp-status')
lsp_status.config {
    indicator_errors = '🌋',
    indicator_warnings = '⛅',
    indicator_info = '🍸',
    indicator_hint = '🦉',
    indicator_ok = '👌',
    status_symbol = '',
    update_interval = 2
}
-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
    lsp_status.on_attach(client)
    require "lsp_signature".on_attach({
        bind = true,           -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = "rounded" -- double, rounded, single, shadow, none
        },
        -- hi_parameter = "IncSearch",
        -- fix_pos = false,
        hi_parameter = "LspSignatureActiveParameter",
        floating_window = true,
        doc_lines = 10,
        hint_enable = true,
        hint_prefix = "🦊 ",
        max_width = 100,
        toggle_key = '<C-l>',
    }, bufnr)
    -- Regular Neovim LSP client keymappings
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
    nnoremap('gd', vim.lsp.buf.definition, bufopts, "Go to definition")
    nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
    nnoremap('K', vim.lsp.buf.hover, bufopts, "Hover text")
    inoremap('<C-K>', vim.lsp.buf.signature_help, bufopts, "Show signature")
    nnoremap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
    nnoremap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
    nnoremap('<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts, "List workspace folders")
    nnoremap('<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
    nnoremap('<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
    nnoremap('<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
    vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Code actions" })
    -- nnoremap('<space>vf', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")
    -- nnoremap('<space>bf', vim.lsp.buf.format, bufopts, "Format file")

    -- Java extensions provided by jdtls
    nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
    nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
    nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
    vim.keymap.set('v', "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
        { noremap = true, silent = true, buffer = bufnr, desc = "Extract method" })

    -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
    -- you make during a debug session immediately.
    -- Remove the option if you do not want that.
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

local config = {
    flags = {
        debounce_text_changes = 80,
    },
    on_attach = on_attach, -- We pass our on_attach keybindings to the configuration map
    init_options = {
        bundles = bundles,
        workspaceFolders = ws_folders_jdtls,
    },
    root_dir = root_dir, -- Set the root directory to our found root_marker
    filetypes = { "java" },
    autostart = true,
    -- Here you can configure eclipse.jdt.ls specific settings
    -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            -- look more into this guide https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/guides/setup-with-nvim-jdtls.md
            format = {
                -- enabled = true,
                -- settings = {
                --   -- Use Google Java style guidelines for formatting
                --   -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
                --   -- and place it in the ~/.local/share/eclipse directory
                --   url = "/.local/share/eclipse/eclipse-java-google-style.xml",
                --   profile = "GoogleStyle",
                -- },
                -- Really good reference
                -- https://astronvim.com/2.9.0/recipes/advanced_lsp
                settings = {
                    -- url = "/Users/millrben/.local/share/jdtls/RDS-eclipse-style.xml",
                    -- url = "/Users/millrben/.local/share/jdtls/RDS-intellij.xml",
                    -- url = "/Users/millrben/.local/share/jdtls/Hmmmm.xml",
                    -- url = "/Users/millrben/.local/share/jdtls/RDS-project.xml",
                    url = "/Users/millrben/.local/share/jdtls/eclipse-java-google-style.xml",
                    -- profile = "RDSStyle",
                    -- Adding profile is only necessary if the xml file has multiple profile blocks and it must match the name= attribute of one of them.
                    -- https://github.com/mfussenegger/nvim-jdtls/discussions/187
                    -- https://github.com/mfussenegger/nvim-jdtls/issues/203
                },
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' }, -- Use fernflower to decompile library code
            -- Specify any completion options
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*", "sun.*",
                },
            },
            -- Specify any options for organizing imports
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            -- How code generation should act
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers} }"
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            -- If you are developing in projects with different Java versions, you need
            -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- And search for `interface RuntimeOption`
            -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = "/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home",
                    },
                    -- {
                    --   name = "JavaSE-11",
                    --   path = home .. "/.asdf/installs/java/corretto-11.0.16.9.1",
                    -- },
                    -- {
                    --   name = "JavaSE-1.8",
                    --   path = home .. "/.asdf/installs/java/corretto-8.352.08.1"
                    -- },
                }
            }
        }
    },
    -- cmd is the command that starts the language server. Whatever is placed
    -- here is what is passed to the command line to execute jdtls.
    -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    -- for the full list of options
    cmd = {
        "/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/bin/java",
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        -- -- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
        -- '-javaagent:' .. home .. '/.local/share/eclipse/lombok.jar',
        '-javaagent:' .. home .. '/.local/share/jdtls/lombok.jar',

        -- The jar file is located where jdtls was installed. This will need to be updated
        -- to the location where you installed jdtls
        -- '-jar', vim.fn.glob('/opt/homebrew/Cellar/jdtls/1.19.0/libexec/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-jar', vim.fn.glob(home .. '/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-jar', vim.fn.glob(home .. '/.local/share/jdtls/plugins/slf4j.api_*.jar'),

        -- The configuration for jdtls is also placed where jdtls was installed. This will
        -- need to be updated depending on your environment
        -- '-configuration', '/opt/homebrew/Cellar/jdtls/1.19.0/libexec/config_mac',
        '-configuration', home .. '/.local/share/jdtls/config',

        -- Use the workspace_folder defined above to store data for this project
        '-data', workspace_folder,
    },
}



-- print(config['init_options']['bundles'][1])
-- Finally, start jdtls. This will run the language server using the configuration we specified,
-- setup the keymappings, and attach the LSP client to the current buffer

-- https://sookocheff.com/post/vim/neovim-java-ide/
-- Manually mason java-debug-adapter, java-test

nnoremap('<space>wf', bemol, bufopts, "Add workspace folder bemol")
nnoremap('<space>bf', vim.lsp.buf.format, bufopts, "Format file")

-- nvim-dap
nnoremap("<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", bufopts, "Set breakpoint")
nnoremap("<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", bufopts,
    "Set conditional breakpoint")
nnoremap("<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", bufopts,
    "Set log point")
nnoremap('<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>", bufopts, "Clear breakpoints")
nnoremap('<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', bufopts, "List breakpoints")

nnoremap("<C-b>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", bufopts, "Dap Set breakpoint")
nnoremap("<M-d>", "<cmd>lua require'dap'.continue()<cr>", bufopts, "Dap Continue")
nnoremap("<M-j>", "<cmd>lua require'dap'.step_over()<cr>", bufopts, "Dap Step over")
nnoremap("<M-l>", "<cmd>lua require'dap'.step_into()<cr>", bufopts, "Dap Step into")
nnoremap("<M-k>", "<cmd>lua require'dap'.step_out()<cr>", bufopts, "Dap Step out")
nnoremap('<M-q>', "<cmd>lua require'dap'.terminate()<cr>", bufopts, "Dap Terminate")
nnoremap('<M-h>', "<cmd>lua require'dap'.restart()<cr>", bufopts, "Dap restart")
nnoremap('<M-u>', "<cmd>lua require'dap'.up()<cr>", bufopts, "Stacktrace up")
nnoremap('<M-i>', "<cmd>lua require'dap'.down()<cr>", bufopts, "Stacktrace down")

nnoremap("<leader>dc", "<cmd>lua require'dap'.continue()<cr>", bufopts, "Continue")
nnoremap("<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", bufopts, "Step over")
nnoremap("<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", bufopts, "Step into")
nnoremap("<leader>do", "<cmd>lua require'dap'.step_out()<cr>", bufopts, "Step out")
nnoremap('<leader>dd', "<cmd>lua require'dap'.disconnect()<cr>", bufopts, "Disconnect")
nnoremap('<leader>dt', "<cmd>lua require'dap'.terminate()<cr>", bufopts, "Terminate")
nnoremap("<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", bufopts, "Open REPL")
nnoremap("<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", bufopts, "Run last")
nnoremap('<leader>di', function() require "dap.ui.widgets".hover() end, bufopts, "Variables")
nnoremap('<leader>d?', function()
    local widgets = require "dap.ui.widgets";
    widgets.centered_float(widgets.scopes)
end, bufopts, "Scopes")
nnoremap('<leader>df', '<cmd>Telescope dap frames<cr>', bufopts, "List frames")
nnoremap('<leader>dh', '<cmd>Telescope dap commands<cr>', bufopts, "List commands")

-- This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
-- https://github.com/mfussenegger/nvim-jdtls
nnoremap("<leader>vc", jdtls.test_class, bufopts, "Test class (DAP)")
nnoremap("<leader>vm", jdtls.test_nearest_method, bufopts, "Test method (DAP)")


-- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
-- must call this setup_dap after jdtls has initialized
-- configuration for remote attach https://github.com/mfussenegger/nvim-dap/wiki/Java#configuration
-- Configuration for manual stuff https://github.com/microsoft/vscode-java-debug#options
nnoremap("<leader>ds", "<cmd>lua require('jdtls').setup_dap({ hotcodereplace = 'auto' })<CR>", bufopts, "Setup java dap")


require('dap.ext.vscode').load_launchjs()

jdtls.start_or_attach(config)

-- this does the job just fine!
-- vim.cmd([[
-- autocmd! BufWritePost * silent! lua bemol()
-- ]])
