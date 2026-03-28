require "nvchad.autocmds"

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
