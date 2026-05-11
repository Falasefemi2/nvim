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
                "sql",
            }
            return opts
        end,
    },
    {
        "jmbuhr/otter.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        ft = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        opts = {},
        config = function(_, opts)
            local otter = require "otter"

            otter.setup(opts)

            local group = vim.api.nvim_create_augroup("embedded_sql_otter", { clear = true })

            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                pattern = {
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                },
                callback = function(args)
                    vim.schedule(function()
                        if vim.api.nvim_buf_is_valid(args.buf) then
                            otter.activate({ "sql" }, true, true)
                        end
                    end)
                end,
            })
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
            local close_tag = internal.close_tag
            local close_slash_tag = internal.close_slash_tag
            local rename_tag = internal.rename_tag

            local function has_parser()
                local ok, parser = pcall(vim.treesitter.get_parser)
                return ok and parser ~= nil
            end

            internal.close_tag = function(...)
                if not has_parser() then
                    return
                end

                return close_tag(...)
            end

            internal.close_slash_tag = function(...)
                if not has_parser() then
                    return
                end

                return close_slash_tag(...)
            end

            internal.rename_tag = function(...)
                if not has_parser() then
                    return
                end

                return rename_tag(...)
            end

            require("nvim-ts-autotag").setup()
        end,
    },
}
