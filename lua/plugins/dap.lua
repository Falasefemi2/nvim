return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require "dap"
            local dapui = require "dapui"

            -- Signs
            vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint" })
            vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DapStopped", linehl = "DapStopped" })

            -- UI setup
            dapui.setup()

            -- Auto open/close UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
            { "<leader>dx", function() require("dap").terminate() end,         desc = "Terminate" },
            { "<leader>ds", function() require("dap").step_over() end,         desc = "Step Over" },
            { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into" },
            { "<leader>do", function() require("dap").step_out() end,          desc = "Step Out" },
            { "<leader>du", function() require("dapui").toggle() end,          desc = "Toggle DAP UI" },
        },
    },
    {
        "leoluz/nvim-dap-go",
        lazy = false,
        dependencies = "mfussenegger/nvim-dap",
        config = function()
            require("dap-go").setup {
                delve = {
                    path = "dlv",
                    initialize_timeout_sec = 30,
                    detached = vim.fn.has "win32" == 0,
                },
            }
        end,
        keys = {
            { "<leader>dt", function() require("dap-go").debug_test() end,      desc = "Debug Nearest Test (Go)" },
            { "<leader>dT", function() require("dap-go").debug_last_test() end, desc = "Debug Last Test (Go)" },
        },
    },
}
