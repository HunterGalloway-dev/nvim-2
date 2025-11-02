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
    },

    -- Apply format-on-save globally
    format_on_save = function()
        return { timeout_ms = 2000, lsp_fallback = true }
    end,
}

return options
