return {
    "mrjones2014/smart-splits.nvim",
    config = function()
        require("smart-splits").setup({
            ignored_filetypes = { "nofile", "quickfix", "qf", "function" },
            default_amount = 3,
        })

        -- Resize with arrow keys
        vim.keymap.set("n", "<C-Left>", require("smart-splits").resize_left)
        vim.keymap.set("n", "<C-Right>", require("smart-splits").resize_right)
        vim.keymap.set("n", "<C-Up>", require("smart-splits").resize_up)
        vim.keymap.set("n", "<C-Down>", require("smart-splits").resize_down)
    end,
}
