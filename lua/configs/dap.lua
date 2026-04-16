-- DAP UI layout + listener wiring.
-- Called from lua/plugins/dap.lua as `require("configs.dap")()`.
return function()
    local dap = require "dap"
    local dapui = require "dapui"

    -- Custom DAP UI layout: scopes + breakpoints sidebar, console along the bottom.
    dapui.setup {
        layouts = {
            {
                elements = {
                    { id = "scopes", size = 0.80 },
                    { id = "breakpoints", size = 0.20 },
                },
                size = 50,
                position = "left",
            },
            {
                elements = {
                    { id = "console", size = 1.0 },
                },
                size = 10,
                position = "bottom",
            },
        },
        controls = {
            enabled = true,
            element = "console",
        },
        floating = {
            max_height = nil,
            max_width = nil,
            border = "rounded",
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
        render = {
            max_type_length = nil,
            max_value_lines = 100,
        },
    }

    -- Open/close UI alongside the debug session.
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end
