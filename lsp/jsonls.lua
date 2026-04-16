return {
    -- Attach to both json and jsonc (tsconfig.json, .eslintrc.json, etc.)
    filetypes = { "json", "jsonc" },
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
}
