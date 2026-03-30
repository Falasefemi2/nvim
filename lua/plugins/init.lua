return {
    {
        "stevearc/conform.nvim",
        opts = require "configs.conform",
    },
    {
        "neovim/nvim-lspconfig",
        deactivate = function() end,
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },
    {
        "williamboman/mason.nvim",
    },
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        config = function(_, opts)
            require("gopher").setup(opts)
        end,
        build = function()
            vim.cmd [[silent! GoInstallDeps]]
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function()
            local opts = require "nvchad.configs.treesitter"
            opts.ensure_installed = {
                "html",
                "css",
                "lua",
                "javascript",
                "typescript",
                "tsx",
                "go",
            }
            return opts
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        config = function()
            local internal = require "nvim-ts-autotag.internal"
            local rename_tag = internal.rename_tag

            internal.rename_tag = function(...)
                local ok, parser = pcall(vim.treesitter.get_parser)
                if not ok or not parser then
                    return
                end

                return rename_tag(...)
            end

            require("nvim-ts-autotag").setup()
        end,
    },
}
