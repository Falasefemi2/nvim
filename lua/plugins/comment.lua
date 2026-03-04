return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()
    
    vim.keymap.set("n", "<Leader>cc", "gcc", { remap = true })  -- Comment line
    vim.keymap.set("v", "<Leader>cc", "gc", { remap = true })   -- Comment selection
    vim.keymap.set("n", "<Leader>cu", "gcc", { remap = true })  -- Uncomment (toggle works both ways)
    vim.keymap.set("v", "<Leader>cu", "gc", { remap = true })
  end,
}
