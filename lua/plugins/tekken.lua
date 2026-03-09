return {
    {
        "soon2moon/tekken.nvim",
        name = "tekken.nvim",
        cmd = { "TekkenToggle", "TekkenNext", "TekkenPrev", "TekkenSync" },
        keys = {
            { "<leader>m", "<cmd>TekkenToggle<cr>", desc = "Tekken: local marks menu" },
            { "]m",        "<cmd>TekkenNext<cr>",   desc = "Tekken: next local mark" },
            { "[m",        "<cmd>TekkenPrev<cr>",   desc = "Tekken: prev local mark" },
        },
        opts = {
            order = "added", -- or "position"
            -- prune_missing = true,
            -- auto_sync = false,      -- set true if you want background syncing
            -- max_width = 140,        -- total combined width (list + gap + preview)
            -- max_height = 14,
            -- list_ratio = 0.40,      -- list width ratio
            -- gap = 2,                -- space between list and preview windows
            -- preview_context = 10,   -- lines above/below the mark
        },
        config = function(_, opts)
            require("tekken").setup(opts)
        end,
    },
}
