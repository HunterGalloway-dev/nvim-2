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
-- Debug Mappings
map("n", "<leader>gdd", "<cmd>GoDebug<CR>", { desc = "Go: launch go dap debugger" })
map("n", "<leader>gdb", "<cmd>GoBreakToggle<CR>", { desc = "Go: toggle break point" })
map("n", "<leader>gdt", "<cmd>GoDebug -t<CR>", { desc = "Go: debug current test" })
map("n", "<leader>gds", "<cmd>DapTerminate<CR>", { desc = "Go: stop current debug session" })
-- Ray X Go Testing Mappings
map("n", "<leader>tgb", "<cmd>GoTestFile -v<CR>", { desc = "Go: Go Test File (Current Buffer)" })
map("n", "<leader>tgf", "<cmd>GoTestFunc -v<CR>", { desc = "Go: Test Function" })

-- Diagnostics (Trouble) — workspace-wide error/warning panel
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Workspace diagnostics (Trouble)" })
map("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics (Trouble)" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols (Trouble)" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list (Trouble)" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list (Trouble)" })

