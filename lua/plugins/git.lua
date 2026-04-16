return {
    -- Floating-terminal Lazygit integration.
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
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },

    -- Inline blame via gitsigns (NvChad already loads gitsigns; this just merges opts).
    -- Replaces git-blame.nvim — same UX, one fewer plugin.
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 300,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = " <author> • <author_time:%m-%d-%Y> • <summary> • <<abbrev_sha>>",
        },
    },
}
