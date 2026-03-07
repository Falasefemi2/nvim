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

local has_ts_ls = pcall(vim.lsp.config, "ts_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
})

if not has_ts_ls then
  vim.lsp.config("tsserver", {
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

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

local servers = {
  "cssls",
  "html",
  "gopls",
  has_ts_ls and "ts_ls" or "tsserver",
  "tailwindcss",
  "emmet_language_server",
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end
