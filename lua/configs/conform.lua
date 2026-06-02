return {
  formatters_by_ft = {
    -- go stuff
    go = { "gofumpt", "goimports_reviser", "golines" },
    -- python stuff
    python = {
      "black",
    },
    -- web dev stuff
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", "djlint", stop_after_first = true },
    markdown = { "prettierd", "prettier", stop_after_first = true },
  },

  format_on_save = {
    -- Enable format on save
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}
