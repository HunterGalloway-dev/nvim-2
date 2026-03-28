-- Returns true only when a biome.json/biome.jsonc exists at or above the current file.
-- Used as a condition so biome doesn't swallow the formatter slot in non-Biome projects.
local function in_biome_project()
    return vim.fs.find({ "biome.json", "biome.jsonc" }, {
        upward = true,
        stop = vim.env.HOME,
        path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
    })[1] ~= nil
end

local options = {
    formatters_by_ft = {
        -- Go
        go = { "gofumpt", "goimports" },
        gomod = { "gofumpt" },
        gowork = { "gofumpt" },

        lua = { "stylua" },

        -- JS/TS/CSS/JSON: biome when biome.json exists, prettier otherwise
        javascript = { "biome", "prettier", stop_after_first = true },
        javascriptreact = { "biome", "prettier", stop_after_first = true },
        typescript = { "biome", "prettier", stop_after_first = true },
        typescriptreact = { "biome", "prettier", stop_after_first = true },
        json = { "biome", "prettier", stop_after_first = true },
        jsonc = { "biome", "prettier", stop_after_first = true },
        css = { "biome", "prettier", stop_after_first = true },

        -- Biome does not cover HTML or Markdown — always use Prettier
        html = { "prettier" },
        markdown = { "prettier" },

        yaml = { "prettier" },

        -- SQL
        sql = { "sql_formatter" },
        mysql = { "sql_formatter" },

        -- Shell (sh covers generic scripts, bash covers #!/bin/bash files)
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- Docker (no standalone formatter — falls back to dockerls via lsp_fallback)
        -- dockerfile = {},

        -- Starlark / Bazel
        starlark = { "buildifier" },
        bzl = { "buildifier" },
    },

    formatters = {
        -- Biome only runs when biome.json is present — prevents it from stealing
        -- the formatter slot in Go/Python/etc projects that have neither biome nor prettier
        biome = {
            condition = in_biome_project,
        },
        prettier = {
            args = {
                "--stdin-filepath",
                "$FILENAME",
                "--tab-width",
                "4",
                "--use-tabs",
                "false",
            },
            stdin = true,
        },
        shfmt = {
            prepend_args = { "-i", "4", "-ci", "-sr" },
        },
        sql_formatter = {
            prepend_args = { "--config", '{"language":"sql","keywordCase":"upper","indentStyle":"standard","tabWidth":4}' },
        },
    },

    format_on_save = function()
        return { timeout_ms = 2000, lsp_fallback = true }
    end,
}

return options
