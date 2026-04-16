return {
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
                "sql",
                "toml",
                "starlark",
                "make",
                "python",
            },
        },
    },

    -- Sticky context header showing the enclosing function/class as you scroll.
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPost",
        opts = {
            enable = true,
            line_numbers = true,
            max_lines = 3,
            trim_scope = "outer",
            mode = "cursor",
            separator = "─",
        },
    },
}
