return {
    "folke/snacks.nvim",
    keys = {
        { "<leader>ff", false }, -- disable default, using fff.nvim instead
    },
    ---@type snacks.Config
    opts = {
        gitbrowse = {
            what = "permalink",
        },
        animate = {},
        picker = {
            sources = {
                grep = {
                    exclude = {
                        ".git",
                        "node_modules",
                        "bower_components",
                        "vendor",
                        "__pycache__",
                        ".pytest_cache",
                        "*.pyc",
                        ".next",
                        ".nuxt",
                        "dist",
                        "build",
                        "out",
                        ".cache",
                        "coverage",
                        "target",
                        ".hg",
                        ".svn",
                    },
                },
            },
        },
        terminal = {
            win = {
                position = "right",
                width = 0.3,
            },
        },
        scroll = {},
    },
}
