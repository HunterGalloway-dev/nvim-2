return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "gopls",
                "gofumpt",
                "goimports",
                "vscode-json-languageserver",
                "yaml-language-server",
                "prettier",
                "bash-language-server",
                "shfmt",
                "shellcheck",
                "typescript-language-server",
                "eslint-lsp",
                "html-lsp",
                "css-lsp",
                "prettier",
                "dockerfile-language-server",
                "docker-compose-language-service",
                "shellcheck",
                "dockfmt",
            },
            automatic_installation = true,
        },
    },
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "b0o/schemastore.nvim",
    },
    -- test new blink
    -- { import = "nvchad.blink.lazyspec" },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "html",
                "css",
                "go",
                "gomod",
                "gowork",
                "gotmpl",
                "json",
                "yaml",
                "bash",
                "javascript",
                "typescript",
                "tsx",
                "dockerfile",
            },
        },
    },
    -- Used to integrate lazygit into the setup
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio", -- Required for nvim-dap-ui
        },
        config = function()
            require("dapui").setup()
            -- Further nvim-dap configuration can go here
        end,
    },
    {
        "leoluz/nvim-dap-go",
    },
    -- Mason integration for DAP adapters
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("mason-nvim-dap").setup {
                -- Optional: automatically install adapters
                ensure_installed = { "python", "delve" },
            }
        end,
    },
    {
        -- https://github.com/ray-x/go.nvim
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            -- lsp_keymaps = false,
            lsp_inlay_hints = {
                enable = false, -- this is the only field apply to neovim > 0.10
            },
            -- icons = { breakpoint = "🅱️", currentpos = "🏃" },
        },
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },

    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        opts = {
            ui = { border = "rounded" },
            hover = { open_link = "gx" },
            lightbulb = {
                enable = false, -- disable feature entirely
                sign = false, -- no gutter lightbulb
                virtual_text = false, -- no end-of-line lightbulb
            },
        },
        config = function(_, opts)
            require("lspsaga").setup(opts)
            vim.keymap.set("n", "gpt", "<cmd>Lspsaga peek_type_definition<cr>", { desc = "Peek type (Saga)" })
            vim.keymap.set("n", "gpd", "<cmd>Lspsaga peek_definition<cr>", { desc = "Peek def (Saga)" })
        end,
    },
    -- LSP / Syntax UX --
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPost",
        opts = {
            enable = true, -- enable by default
            line_numbers = true, -- show line numbers for context
            max_lines = 3, -- limit height
            trim_scope = "outer", -- how to shrink context lines
            mode = "cursor", -- update as cursor moves
            separator = "─", -- horizontal separator line
        },
    },
    {
        "f-person/git-blame.nvim",
        -- load the plugin at startup
        event = "VeryLazy",
        -- Because of the keys part, you will be lazy loading this plugin.
        -- The plugin will only load once one of the keys is used.
        -- If you want to load the plugin at startup, add something like event = "VeryLazy",
        -- or lazy = false. One of both options will work.
        opts = {
            -- your configuration comes here
            -- for example
            enabled = true, -- if you want to enable the plugin
            message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
            date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
            virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
        },
    },
    -- {
    --     "nvim-tree/nvim-tree.lua",
    --     opts = {
    --         view = {
    --             side = "right"
    --         }
    --     }
    -- }
}
