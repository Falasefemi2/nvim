return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Show diagnostics in a floating window on hover
      vim.o.updatetime = 250
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, { focus = false })
        end,
      })

      -- Virtual text for diagnostics
      vim.diagnostic.config({
        virtual_text = true,
        float = { border = "rounded" },
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      -- Set diagnostic signs
      local signs = { Error = "✘", Warn = "▲", Hint = "◆", Info = "ℹ" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Keymaps for diagnostics
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>D", vim.diagnostic.setloclist, { desc = "Show diagnostics" })
    end,
  },
}
