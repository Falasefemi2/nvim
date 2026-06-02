return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {},
    keys = {
        {
            "<leader>hm",
            function()
                require("harpoon"):list():add()
            end,
            desc = "Mark file with harpoon",
        },
        {
            "<leader>hr",
            function()
                require("harpoon"):list():remove()
            end,
            desc = "Remove file with harpoon",
        },
        {
            "<leader>hn",
            function()
                require("harpoon"):list():next()
            end,
            desc = "Go to next harpoon mark",
        },
        {
            "<leader>hp",
            function()
                require("harpoon"):list():prev()
            end,
            desc = "Go to previous harpoon mark",
        },
        {
            "<leader>ha",
            function()
                local harpoon = require "harpoon"
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "Show harpoon marks",
        },
        {
            "<leader>h1",
            function()
                require("harpoon"):list():select(1)
            end,
            desc = "Harpoon first file",
        },
        {
            "<leader>h2",
            function()
                require("harpoon"):list():select(2)
            end,
            desc = "Harpoon second file",
        },
        {
            "<leader>h3",
            function()
                require("harpoon"):list():select(3)
            end,
            desc = "Harpoon third file",
        },
    },
}
