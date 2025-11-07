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

-- Cursor line (optional)
-- o.cursorlineopt = "both"

-- Folding (Treesitter-based)
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = true
o.foldlevel = 99           -- Keeps folds open by default
o.foldlevelstart = 99
o.foldnestmax = 4          -- Optional: limit how deep folds go
o.foldminlines = 1         -- Minimum lines for a fold to be created
