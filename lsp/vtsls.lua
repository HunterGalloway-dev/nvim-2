return {
    cmd = { "vtsls", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    on_attach = function(client)
        -- Biome handles formatting; vtsls is for type-checking and intelligence only
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
