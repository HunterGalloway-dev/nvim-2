require "nvchad.autocmds"

-- Enable inlay hints on every LSP attach when the server supports them.
-- Server-side hint settings live in ~/.config/nvim/lsp/<name>.lua (gopls, vtsls).
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method "textDocument/inlayHint" then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})

-- Highlight printf-style format verbs (%s, %d, %w, etc.) inside Go strings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.fn.matchadd("@string.escape", "%[-+ #0-9*.]*[vTtbcdoOqxXUeEfFgGspwW%]")
    end,
})

-- Makefiles require real tabs — override the global expandtab setting
vim.api.nvim_create_autocmd("FileType", {
    pattern = "make",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

-- Starlark filetype detection
-- Neovim detects .bzl natively but not BUILD/WORKSPACE/MODULE files or .star
vim.filetype.add {
    extension = {
        star = "starlark",
    },
    filename = {
        ["BUILD"] = "starlark",
        ["BUILD.bazel"] = "starlark",
        ["WORKSPACE"] = "starlark",
        ["WORKSPACE.bazel"] = "starlark",
        ["MODULE.bazel"] = "starlark",
    },
}

-- JSONC filetype detection for files that allow comments
-- Without this they get 'json' and prettier/jsonls may choke on the comments
vim.filetype.add {
    extension = {
        jsonc = "jsonc",
    },
    filename = {
        ["tsconfig.json"] = "jsonc",
        [".eslintrc.json"] = "jsonc",
        [".babelrc"] = "jsonc",
        ["devcontainer.json"] = "jsonc",
        [".vscode/settings.json"] = "jsonc",
        [".vscode/launch.json"] = "jsonc",
        [".vscode/tasks.json"] = "jsonc",
    },
    pattern = {
        -- any tsconfig variant: tsconfig.app.json, tsconfig.build.json, etc.
        ["tsconfig%..*%.json"] = "jsonc",
    },
}
