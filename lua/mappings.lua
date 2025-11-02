require "nvchad.mappings"
local map = vim.keymap.set
local term = require("nvchad.term")

-- Common keymaps
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- LSP Mappings
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

-- Integrated terminals
map({ "n", "t" }, "<leader>tf", function()
  term.toggle({ pos = "float", id = "floatTerm" })
end, { desc = "Toggle floating terminal" })

-- Ray X Go plugins
map("n", "<leader>ge", "<cmd>GoIfErr<CR>", { desc = "Go: insert if err != nil" })
