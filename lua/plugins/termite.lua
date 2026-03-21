return {
    {
        '2kabhishek/termim.nvim',
        cmd = { 'Fterm', 'FTerm', 'Sterm', 'STerm', 'Tterm', 'TTerm', 'Vterm', 'VTerm' },
        keys = {
            { "<leader>tt", "<cmd>STerm<CR>", mode = { "n", "t" }, desc = "Terminal toggle" },
            { "<leader>tv", "<cmd>VTerm<CR>", mode = { "n", "t" }, desc = "Terminal vertical toggle" },
            { "<leader>tf", "<cmd>FTerm<CR>", mode = { "n", "t" }, desc = "Terminal floating toggle" },
            { "<leader>tn", "<cmd>Sterm<CR>", mode = { "n", "t" }, desc = "Terminal new split" },
            { "<leader>tN", "<cmd>Vterm<CR>", mode = { "n", "t" }, desc = "Terminal new vertical" },
            { "<leader>tp", "<cmd>TTerm<CR>", mode = { "n", "t" }, desc = "Terminal tab toggle" },
        },
    },
}
