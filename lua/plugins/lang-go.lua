return {
    -- ray-x/go.nvim: only used for the commands bound in lua/mappings.lua
    -- (GoIfErr, GoAddTag/GoRmTag, GoDebug, GoBreakToggle, GoTestFile, GoTestFunc).
    -- Most of go.nvim's other subsystems are explicitly disabled below to keep
    -- Go file open fast.
    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
        opts = {
            -- gopls is configured in ~/.config/nvim/lsp/gopls.lua
            lsp_cfg = false,
            lsp_keymaps = false,
            lsp_codelens = false,
            -- Inlay hints handled globally via LspAttach autocmd in lua/autocmds.lua
            lsp_inlay_hints = { enable = false },
            -- vim.diagnostic + Trouble already cover this
            diagnostic = false,
            -- nvim-dap-ui owns the debug UI
            dap_debug = true,
            dap_debug_gui = false,
            dap_debug_keymap = false,
            -- conform.nvim handles formatting on save
            null_ls_document_formatting_disable = true,
            gofmt = "gofumpt",
            -- Snippets come from friendly-snippets via blink.cmp
            luasnip = false,
        },
    },
}
