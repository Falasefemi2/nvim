return {
    {
        'pablobfonseca/cyberpunk-theme',
        lazy = false,
        priority = 1000,
        config = function()
            require('cyberpunk').setup({
                -- Your config here
            })
        end,
    }
}
