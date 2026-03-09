return {
    {
        "olexsmir/gopher.nvim",
        opts = {},
    },
    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup({
                lsp_cfg = {
                    on_attach = function(client, bufnr)
                        pcall(vim.keymap.del, "n", "<leader>e", { buffer = bufnr })
                    end,
                    settings = {
                        gopls = {
                            buildFlags = { "-tags=cli,test,gencmd,trustcenter" },
                            gofumpt = true, -- ensures strict formatting
                            staticcheck = true,
                        },
                    },
                },
                -- do NOT auto goimports to avoid accidental deletion
                goimport = "gofumpt", -- safer formatting only
            })

            local format_grp = vim.api.nvim_create_augroup("GoFormat", { clear = true })

            -- Safe format on save (no import removal)
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require("go.format").gofmt() -- only formats code
                end,
                group = format_grp,
            })
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
        keys = {
            { "<leader>gaj",   "<cmd>GoAddTag<cr>",                   desc = "Add json tags" },
            { "<leader>gam",   "<cmd>GoAddTag mapstructure<cr>",      desc = "Add mapstructure tags" },
            { "<leader>gae",   "<cmd>GoAddTag env<cr>",               desc = "Add env tags" },
            { "<leader>gay",   "<cmd>GoAddTag yaml<cr>",              desc = "Add YAML tags" },
            { "<leader>gasvr", "<cmd>GoAddTag validate:required<cr>", desc = "Add Swagger validate required tags" },
            { "<leader>gasvo", "<cmd>GoAddTag validate:optional<cr>", desc = "Add Swagger validate optional tags" },
            { "<leader>gim",   "<cmd>GoImplements<cr>",               desc = "Find implementions of this method" },
            { "<leader>gi",    "<cmd>GoImports<cr>",                  desc = "Manually fix imports" }, -- manual imports only
        },
    },
}
