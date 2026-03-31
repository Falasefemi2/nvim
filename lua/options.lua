require "nvchad.options"
-- add yours here!
local o = vim.opt
o.relativenumber = true
o.tabstop = 4
o.shiftwidth = 4
vim.o.exrc = true
vim.o.secure = true
vim.api.nvim_create_autocmd("filetype", {
    pattern = { "html" },
    callback = function()
        vim.opt_local.expandtab = true
    end,
})
