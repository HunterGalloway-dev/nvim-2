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
            local dap = require "dap"
            local dapui = require "dapui"

            -- Custom DAP UI layout with only console, breakpoints, and scopes (local variables)
            dapui.setup {
                layouts = {
                    {
                        -- Left sidebar: local variables and breakpoints
                        elements = {
                            { id = "scopes", size = 0.80 }, -- Local variables (60% of left panel)
                            { id = "breakpoints", size = 0.20 }, -- Breakpoints (40% of left panel)
                        },
                        size = 50, -- Width of left sidebar in columns
                        position = "left",
                    },
                    {
                        -- Bottom panel: console spanning full width
                        elements = {
                            { id = "console", size = 1.0 }, -- Console takes full bottom panel
                        },
                        size = 10, -- Height of bottom panel in rows
                        position = "bottom",
                    },
                },
                controls = {
                    enabled = true,
                    element = "console",
                },
                floating = {
                    max_height = nil,
                    max_width = nil,
                    border = "rounded",
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil,
                    max_value_lines = 100,
                },
            }

            -- Automatically open/close DAP UI when debugging starts/ends
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
    {
        "leoluz/nvim-dap-go",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("dap-go").setup()
        end,
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
                ensure_installed = { "python", "delve" },
            }
        end,
    },
    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            lsp_inlay_hints = {
                enable = false,
            },
            -- Disable ray-x/go.nvim's DAP UI to prevent conflicts
            dap_debug = true,
            dap_debug_gui = false, -- This prevents go.nvim from setting up its own DAP UI
        },
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
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
    {
        "nvim-telescope/telescope.nvim",
        opts = function(_, conf)
            -- Ensure defaults and pickers exist
            conf.defaults = conf.defaults or {}
            conf.pickers = conf.pickers or {}

            -- File ignore patterns for better performance
            conf.defaults.file_ignore_patterns = {
                ".git/",
                "vendor/",
                "node_modules/",
                "dist/",
                "build/",
                "tmp/",
                "telemetry/",
                "raw_data/",
                "__pycache__/",
                "%.log",
                "%.out",
                "%.test",
                "%.exe",
                "%.dll",
                "%.so",
                "%.db",
                "%.sqlite",
                ".DS_Store",
            }

            -- Finder behavior
            conf.pickers.find_files = {
                hidden = true, -- show hidden files (like .env, .nvim)
                no_ignore = false, -- respect .gitignore
                follow = true, -- follow symlinks
            }

            -- Optional: layout improvements for widescreen monitors
            conf.defaults.layout_config = {
                horizontal = { preview_width = 0.55 },
                vertical = { preview_height = 0.5 },
            }

            return conf
        end,
    },
}
