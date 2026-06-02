return {
    "mrjones2014/smart-splits.nvim",
    keys = {
        { "<C-Left>", function() require("smart-splits").resize_left() end, desc = "Resize split left" },
        { "<C-Right>", function() require("smart-splits").resize_right() end, desc = "Resize split right" },
        { "<C-Up>", function() require("smart-splits").resize_up() end, desc = "Resize split up" },
        { "<C-Down>", function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    },
    opts = {
        ignored_filetypes = { "nofile", "quickfix", "qf", "function" },
        default_amount = 3,
    },
    config = function(_, opts)
        require("smart-splits").setup(opts)
    end,
}
