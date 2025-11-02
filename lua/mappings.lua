require "nvchad.mappings"
local map = vim.keymap.set
local term = require "nvchad.term"

-- Common keymaps
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- LSP Mappings
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

-- Integrated terminals
map({ "n", "t" }, "<leader>tf", function()
    term.toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle floating terminal" })

-- Ray X Go plugins
map("n", "<leader>ge", "<cmd>GoIfErr<CR>", { desc = "Go: insert if err != nil" })
map("n", "<leader>gjt", "<cmd>GoAddTag json<CR>", { desc = "Go: add json tags to a struct" })
map("n", "<leader>gbt", "<cmd>GoAddTag bson<CR>", { desc = "Go: add bson tags to a struct" })
map("n", "<leader>gjr", "<cmd>GoRmTag json<CR>", { desc = "Go: remove json tags from a struct" })
map("n", "<leader>gbr", "<cmd>GoRmTag bson<CR>", { desc = "Go: remove json tags from a struct" })
map("n", "<leader>gdd", "<cmd>GoDebug<CR>", { desc = "Go: launch go dap debugger" })
map("n", "<leader>gdb", "<cmd>GoDebug -b<CR>", { desc = "Go: toggle break point" })
