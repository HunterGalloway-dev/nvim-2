return {
    -- Mason: package manager for LSP servers, formatters, linters, debuggers.
    {
        "williamboman/mason.nvim",
        opts = {},
    },

    -- Auto-installs any missing Mason packages on startup (re-checks once per day).
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        event = "VeryLazy",
        opts = {
            ensure_installed = {
                -- Go
                "gopls",
                "gofumpt",
                "goimports",
                "golangci-lint",
                "delve", -- DAP adapter for Go
                -- Python
                "pyright",
                "ruff",
                "debugpy", -- DAP adapter for Python
                -- Web / React (Biome replaces ESLint + Prettier for JS/TS projects)
                "vtsls", -- replaces typescript-language-server: lighter, faster
                "biome",
                "html-lsp",
                "css-lsp",
                "emmet-language-server",
                "prettier", -- fallback for HTML/Markdown not covered by Biome
                -- SQL
                "sqls",
                "sql-formatter",
                -- Kubernetes / Helm
                "helm-ls",
                -- Data formats
                "json-lsp",
                "yaml-language-server",
                -- Shell
                "bash-language-server",
                "shfmt",
                "shellcheck",
                "checkmake",
                -- Docker
                "dockerfile-language-server",
                "docker-compose-language-service",
                "hadolint",
                -- Starlark (ETL transforms via custom Go engine)
                -- starpls omitted: it's Bazel-specific and would produce false errors
                -- for custom mounted modules (json, etc.)
                "buildifier",
                -- Lua
                "stylua",
            },
            run_on_start = true,
            debounce_hours = 24,
        },
    },

    -- Core LSP. Per-server configs live in ~/.config/nvim/lsp/<name>.lua and are
    -- loaded automatically by vim.lsp.enable (Neovim 0.11+).
    {
        "neovim/nvim-lspconfig",
        dependencies = { "b0o/schemastore.nvim" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()

            -- Force gopls to use the source-built binary in ~/go/bin instead of
            -- whatever wins on $PATH (Mason's lags the current Go release).
            -- Done here, not in lsp/gopls.lua, so it runs after all lsp/*.lua
            -- files merge and is guaranteed to win.
            vim.lsp.config("gopls", {
                cmd = { vim.fn.expand "~/go/bin/gopls" },
            })

            vim.lsp.enable {
                "gopls",
                "pyright",
                "jsonls",
                "bashls",
                "yamlls",
                "vtsls",
                "biome",
                "emmet_language_server",
                "sqls",
                "helm_ls",
                "html",
                "cssls",
                "dockerls",
                "docker_compose_language_service",
            }
        end,
    },

    -- Lightweight peek windows for definitions / type definitions.
    -- Replaces lspsaga (heavier, less maintained).
    {
        "DNLHC/glance.nvim",
        cmd = "Glance",
        keys = {
            { "gpd", "<cmd>Glance definitions<cr>", desc = "Peek def (Glance)" },
            { "gpt", "<cmd>Glance type_definitions<cr>", desc = "Peek type (Glance)" },
        },
        opts = {
            border = { enable = true },
        },
    },
}
