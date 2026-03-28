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
            hoverKind = "FullDocumentation",
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
    -- Attach to both json and jsonc (tsconfig.json, .eslintrc.json, etc.)
    filetypes = { "json", "jsonc" },
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
        -- Biome handles formatting; ts_ls is for type-checking and intelligence only
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    single_file_support = true,
    settings = {
        typescript = {
            inlayHints = {
                -- Show parameter names for non-obvious call sites
                includeInlayParameterNameHints = "literals",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                -- Show return types on functions without explicit annotations
                includeInlayFunctionLikeReturnTypeHints = true,
                -- Keep variable type hints off — too noisy with React state
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayEnumMemberValueHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "literals",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayEnumMemberValueHints = true,
            },
        },
    },
}

-- Emmet: fast JSX/HTML tag expansion (e.g. div.container>ul>li*3)
vim.lsp.config["emmet_language_server"] = {
    cmd = { "emmet-language-server", "--stdio" },
    filetypes = {
        "html",
        "css",
        "javascriptreact",
        "typescriptreact",
    },
    single_file_support = true,
}

-- Biome LSP: linting + formatting for JS/TS/JSX/TSX/JSON/CSS in Biome projects
-- Activates when biome.json / biome.jsonc is present at the project root
vim.lsp.config["biome"] = {
    cmd = { "biome", "lsp-proxy" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "json",
        "jsonc",
        "css",
    },
    root_markers = { "biome.json", "biome.jsonc" },
    single_file_support = false,
}

-- SQL LSP
vim.lsp.config["sqls"] = {
    cmd = { "sqls" },
    filetypes = { "sql", "mysql" },
}

-- Helm LSP (Kubernetes chart templates)
vim.lsp.config["helm_ls"] = {
    cmd = { "helm_ls", "serve" },
    filetypes = { "helm" },
    settings = {
        ["helm-ls"] = {
            yamlls = { path = "yaml-language-server" },
        },
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
    "biome",
    "emmet_language_server",
    "sqls",
    "helm_ls",
    "html",
    "cssls",
    "dockerls",
    "docker_compose_language_service",
}
vim.lsp.enable(servers)
