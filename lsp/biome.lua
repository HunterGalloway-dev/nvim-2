-- Biome LSP: linting + formatting for JS/TS/JSX/TSX/JSON/CSS in Biome projects
-- Activates when biome.json / biome.jsonc is present at the project root
return {
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
