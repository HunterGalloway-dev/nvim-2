return {
    -- Core DAP client + UI. mason-tool-installer ships delve & debugpy
    -- (see lua/plugins/lsp.lua), so the language adapters below find their binaries.
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            require "configs.dap"()
        end,
    },

    -- Go DAP adapter (delve).
    {
        "leoluz/nvim-dap-go",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require("dap-go").setup()
        end,
    },

    -- Python DAP adapter (debugpy installed via mason-tool-installer).
    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = "python",
        config = function()
            local mason_python = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(mason_python)
        end,
    },

    -- Inline values during debugging.
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    },
}
