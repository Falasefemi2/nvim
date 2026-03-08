-- Diagnostic UI settings only. Keep this outside plugin `config` for nvim-lspconfig
-- so it doesn't override the real LSP setup in lua/plugins/init.lua.
vim.o.updatetime = 250

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  float = { border = "rounded" },
  signs = true,
  underline = true,
  update_in_insert = false,
})

local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>D", vim.diagnostic.setloclist, { desc = "Show diagnostics" })

return {}
