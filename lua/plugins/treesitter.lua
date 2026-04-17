-- nvim-treesitter `main` branch.
--
-- The legacy `master` branch (config via `setup({ ensure_installed = ... })`,
-- the `highlight`/`indent`/etc. modules) is in maintenance mode and has known
-- incompatibilities with Neovim 0.12 — notably a crash in `query_predicates.lua`
-- when rendering markdown injections inside LSP hover popups.
--
-- The `main` branch removes the module system entirely. Parsers are installed
-- imperatively via `require("nvim-treesitter").install({...})`, and treesitter
-- highlighting is started per-buffer via a FileType autocmd.
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install {
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
                "toml",
                "bash",
                "make",
                "javascript",
                "typescript",
                "tsx",
                "dockerfile",
                "sql",
                "starlark",
                "python",
                -- Required for clean LSP hover popups (markdown content with
                -- inline code/links). Without these, `K` crashes on 0.12.
                "markdown",
                "markdown_inline",
            }

            -- Start treesitter for any buffer whose filetype has a parser
            -- available. pcall so filetypes without parsers fail silently.
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    },

    -- Sticky context header showing the enclosing function/class as you scroll.
    -- Works on either nvim-treesitter branch — consumes parsers via vim.treesitter.
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
