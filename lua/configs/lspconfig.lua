-- Keep NvChad defaults
require("nvchad.configs.lspconfig").defaults()

-- Configure Go (gopls)
vim.lsp.config["gopls"] = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gotmpl", "gowork" },
    settings = {
        gopls = {
            gofumpt = true,
            staticcheck = true,
            -- usePlaceholders = true,
            analyses = {
                unusedparams = true,
                shadow = true,
                unreachable = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
}

-- JSON LSP (vscode-json-languageserver)
vim.lsp.config["jsonls"] = {
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
}

-- YAML LSP (yaml-language-server)
vim.lsp.config["yamlls"] = {
    settings = {
        yaml = {
            schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
            },
            validate = true,
            hover = true,
            completion = true,
        },
    },
}

-- Bash LSP (bash-language-server)
vim.lsp.config["bashls"] = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh" }, -- covers .sh (and many zsh files detected as 'sh')
    -- optional:
    -- settings = {
    --   bashIde = {
    --     globPattern = "*/**/*@(.sh|.bash|.inc|.command)"
    --   },
    -- },
}

-- Enable all LSP servers
local servers = { "gopls", "jsonls", "bashls", "yamlls", "html", "cssls" }
vim.lsp.enable(servers)
