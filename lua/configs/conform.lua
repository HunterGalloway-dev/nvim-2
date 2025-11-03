local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofumpt", "goimports" },
        gomod = { "gofumpt" },
        gowork = { "gofumpt" },
        gosum = { "gosum" },
        -- css = { "prettier" },
        -- html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        sh = { "shfmt" },
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
            -- -i 4 = indent 4 spaces
            -- -ci = indent switch-case
            -- -sr = redirect follows style
            prepend_args = { "-i", "4", "-ci", "-sr" },
        },
    },

    -- Apply format-on-save globally
    format_on_save = function()
        return { timeout_ms = 2000, lsp_fallback = true }
    end,
}

return options
