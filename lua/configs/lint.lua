-- nvim-lint per-filetype linter map + on-save trigger.
-- Called from lua/plugins/editor.lua as `require("configs.lint")()`.
return function()
    local lint = require "lint"

    lint.linters_by_ft = {
        python = { "ruff" },
        starlark = { "buildifier" },
        bzl = { "buildifier" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        dockerfile = { "hadolint" },
        make = { "checkmake" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufReadPost" }, {
        callback = function()
            lint.try_lint()
        end,
    })
end
