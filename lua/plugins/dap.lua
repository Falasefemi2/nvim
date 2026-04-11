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
        "mxsdev/nvim-dap-vscode-js",
        ft = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            local dap = require "dap"
            local mason_packages = vim.fs.joinpath(vim.fn.stdpath "data", "mason", "packages")
            local debugger_path = vim.fs.joinpath(mason_packages, "js-debug-adapter", "js-debug", "src", "dapDebugServer.js")

            require("dap-vscode-js").setup {
                debugger_path = debugger_path,
                adapters = {
                    "pwa-node",
                    "pwa-chrome",
                    "pwa-msedge",
                    "node-terminal",
                },
            }

            local js_filetypes = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
            }

            local js_configurations = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch current file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    sourceMaps = true,
                    resolveSourceMapLocations = {
                        "${workspaceFolder}/**",
                        "!**/node_modules/**",
                    },
                    skipFiles = {
                        "<node_internals>/**",
                        "${workspaceFolder}/node_modules/**",
                    },
                    console = "integratedTerminal",
                },
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch current file with ts-node",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    runtimeExecutable = "node",
                    runtimeArgs = {
                        "--loader",
                        "ts-node/esm",
                    },
                    sourceMaps = true,
                    resolveSourceMapLocations = {
                        "${workspaceFolder}/**",
                        "!**/node_modules/**",
                    },
                    skipFiles = {
                        "<node_internals>/**",
                        "${workspaceFolder}/node_modules/**",
                    },
                    console = "integratedTerminal",
                },
                {
                    type = "pwa-node",
                    request = "attach",
                    name = "Attach to process",
                    processId = require("dap.utils").pick_process,
                    cwd = "${workspaceFolder}",
                    skipFiles = {
                        "<node_internals>/**",
                        "${workspaceFolder}/node_modules/**",
                    },
                },
                {
                    type = "pwa-chrome",
                    request = "launch",
                    name = "Launch Chrome against localhost",
                    url = "http://localhost:3000",
                    webRoot = "${workspaceFolder}",
                    sourceMaps = true,
                    protocol = "inspector",
                },
            }

            for _, language in ipairs(js_filetypes) do
                dap.configurations[language] = js_configurations
            end
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
