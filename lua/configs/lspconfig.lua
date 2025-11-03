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

vim.lsp.config["ts_ls"] = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    on_attach = function(client)
        -- let Prettier handle formatting
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    single_file_support = true,
}

-- ESLint LSP (diagnostics only; keep Prettier for formatting)
vim.lsp.config["eslint"] = {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    -- do NOT let ESLint format; we use Prettier via Conform
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
        -- Run on the same files we listed above
        validate = "on",
        workingDirectory = { mode = "auto" },
    },
}

-- Dockerfile LSP
vim.lsp.config["dockerls"] = {
    -- defaults are fine; attaches to filetype "dockerfile"
}

-- docker-compose LSP
vim.lsp.config["docker_compose_language_service"] = {
    -- attaches to compose YAML files (docker-compose.yml/.yaml)
}

-- Enable all LSP servers
local servers = {
    "gopls",
    "jsonls",
    "bashls",
    "yamlls",
    "ts_ls",
    "eslint",
    "html",
    "cssls",
    "dockerls",
    "docker_compose_language_service",
}
vim.lsp.enable(servers)
