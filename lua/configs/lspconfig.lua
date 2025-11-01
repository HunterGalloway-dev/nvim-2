-- Keep NvChad defaults
require("nvchad.configs.lspconfig").defaults()

-- Configure gopls (Neovim 0.11+ LSP config API)
vim.lsp.config["gopls"] = {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
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

-- Enable the servers you want
local servers = { "gopls", "html", "cssls" }
vim.lsp.enable(servers)

-- Tip: see :h vim.lsp.config for more per-server options
