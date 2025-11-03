local options = {
    formatters_by_ft = {
        -- Go
        go = { "gofumpt", "goimports" },
        gomod = { "gofumpt" },
        gowork = { "gofumpt" },
        gosum = { "gosum" },

        lua = { "stylua" },

        json = { "prettier" },
        yaml = { "prettier" },

        -- Shell
        sh = { "shfmt" },

        javascript = { "prettier" },
        javascriptreact = { "prettier" }, -- .jsx
        typescript = { "prettier" },
        typescriptreact = { "prettier" }, -- .tsx

        -- docker
        dockerfile = { "dockfmt" },

        -- (optional)
        css = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier" },
    },

    formatters = {
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
            -- -i 4 = indent 4 spaces; -ci = indent switch/case; -sr = redirect style
            prepend_args = { "-i", "4", "-ci", "-sr" },
        },
    },

    -- Apply format-on-save globally
    format_on_save = function()
        return { timeout_ms = 2000, lsp_fallback = true }
    end,
}

return options
