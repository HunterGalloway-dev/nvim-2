return {
    {
        "nvim-telescope/telescope.nvim",
        opts = require "configs.telescope",
    },

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = require "configs.conform",
    },

    -- Async linter runner (ruff, buildifier, shellcheck, hadolint, checkmake).
    {
        "mfussenegger/nvim-lint",
        event = { "BufWritePost", "BufReadPost", "InsertLeave" },
        config = function()
            require "configs.lint"()
        end,
    },

    -- Workspace diagnostics panel for LSP errors/warnings across open files.
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Trouble",
        opts = {
            modes = {
                diagnostics = { auto_close = true },
            },
        },
    },
}
