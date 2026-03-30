return {
    {
        "mfussenegger/nvim-dap",
        lazy = false,
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
            { "<leader>dx", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>ds", function() require("dap").step_over() end, desc = "Step Over" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
        },
        config = function()
            vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DapBreakpoint" })
            vim.fn.sign_define("DapStopped", { text = ">", texthl = "DapStopped", linehl = "DapStopped" })
        end,
    },
    {
        "nvim-neotest/nvim-nio",
        lazy = false,
    },
    {
        "rcarriga/nvim-dap-ui",
        lazy = false,
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        keys = {
            {
                "<leader>du",
                function()
                    local ok, dapui = pcall(require, "dapui")
                    if ok then
                        dapui.toggle()
                    else
                        vim.notify("nvim-dap-ui is unavailable: " .. dapui, vim.log.levels.WARN)
                    end
                end,
                desc = "Toggle DAP UI",
            },
        },
        config = function()
            local dap = require "dap"
            local ok, dapui = pcall(require, "dapui")
            if not ok then
                vim.schedule(function()
                    vim.notify("Skipping nvim-dap-ui setup: " .. dapui, vim.log.levels.WARN)
                end)
                return
            end

            dapui.setup()

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
    },
    {
        "leoluz/nvim-dap-go",
        ft = "go",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
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
            { "<leader>dt", function() require("dap-go").debug_test() end, desc = "Debug Nearest Test (Go)" },
            { "<leader>dT", function() require("dap-go").debug_last_test() end, desc = "Debug Last Test (Go)" },
        },
    },
}
