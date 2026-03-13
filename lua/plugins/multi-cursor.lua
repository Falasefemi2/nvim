return {
    {
        "khoido2003/multiple-cursor.nvim",
        keys = {
            { "<C-s>", "<cmd>MultipleCursorStart<cr>", desc = "Start Multiple Cursor" },
        },
        cmd = { "MultipleCursorStart", "MultipleCursorSelectAll" },
        config = function()
            require("multiple-cursor").setup()
        end,
    }
}
