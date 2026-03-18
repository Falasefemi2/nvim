-- New style for nvim 0.11+
local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

vim.lsp.config("cssls", {
    on_attach = on_attach,
    capabilities = capabilities,
})

vim.lsp.config("html", {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html" },
})

vim.lsp.config("gopls", {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
            gofumpt = true,
        },
    },
})


vim.lsp.config("ts_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = "none",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = false,
                includeInlayEnumMemberValueHints = false,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "none",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = false,
                includeInlayEnumMemberValueHints = false,
            },
        },
    },
})

vim.lsp.config("tailwindcss", {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
        "html", "css", "scss",
        "javascript", "javascriptreact",
        "typescript", "typescriptreact",
    },
})

vim.lsp.config("emmet_language_server", {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
        "html", "css",
        "javascript", "javascriptreact",
        "typescript", "typescriptreact",
    },
})

vim.lsp.config("sqls", {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
        "sql"
    },
})

local servers = {
    "cssls",
    "html",
    "gopls",
    "ts_ls",
    "tailwindcss",
    "emmet_language_server",
    "sqls",
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end
