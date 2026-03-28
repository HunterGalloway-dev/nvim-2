require "nvchad.autocmds"

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
