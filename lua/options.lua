require "nvchad.options"

-- add yours here!
local o = vim.o

-- Indentation
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true

-- Line numbers
o.number = true
o.relativenumber = true

-- Folding (Treesitter-based). Uses Neovim's built-in foldexpr — the old
-- `nvim_treesitter#foldexpr()` is a master-branch Vim global that doesn't
-- exist on the `main` branch.
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldenable = true
o.foldlevel = 99           -- Keeps folds open by default
o.foldlevelstart = 99
o.foldnestmax = 4          -- Optional: limit how deep folds go
o.foldminlines = 1         -- Minimum lines for a fold to be created

