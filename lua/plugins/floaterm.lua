return {
  "voldikss/vim-floaterm",
  -- load when any of the terminal-related leader keys are pressed
  keys = {
    { "<leader>t1", mode = "n", desc = "Focus terminal 1" },
    { "<leader>t2", mode = "n", desc = "Focus terminal 2" },
    { "<leader>t3", mode = "n", desc = "Focus terminal 3" },
    { "<leader>t4", mode = "n", desc = "Focus terminal 4" },
    { "<leader>tt1", mode = "n", desc = "Toggle terminal 1" },
    { "<leader>tt2", mode = "n", desc = "Toggle terminal 2" },
    { "<leader>tt3", mode = "n", desc = "Toggle terminal 3" },
    { "<leader>tt4", mode = "n", desc = "Toggle terminal 4" },
    { "<leader>tn",  mode = "n", desc = "New extra terminal" },
    { "<leader>tl",  mode = "n", desc = "List all terminals" },
    { "<leader>tk1", mode = "n", desc = "Kill terminal 1" },
    { "<leader>tk2", mode = "n", desc = "Kill terminal 2" },
    { "<leader>tk3", mode = "n", desc = "Kill terminal 3" },
    { "<leader>tk4", mode = "n", desc = "Kill terminal 4" },
  },
  config = function()
    vim.g.floaterm_width = 0.45
    vim.g.floaterm_height = 0.45
    vim.g.floaterm_wintype = "float"
    
    -- Track if terminals are created
    local terminals = { term1 = false, term2 = false, term3 = false, term4 = false }

    -- When a floaterm buffer is wiped, mark it as not existing
    vim.api.nvim_create_autocmd({ "BufWipeout", "BufDelete" }, {
      callback = function(args)
        local ok, name = pcall(vim.api.nvim_buf_get_var, args.buf, "floaterm_name")
        if ok and name and terminals[name] ~= nil then
          terminals[name] = false
        end
      end,
    })
    
    -- Focus terminal: create if new, switch to it if exists
    local function focus_terminal(name, position)
      if not terminals[name] then
        -- First time: create it
        vim.cmd("FloatermNew --name=" .. name .. " --position=" .. position .. " --width=0.45 --height=0.45")
        terminals[name] = true
      else
        -- Already exists: show it, then update (must be in floaterm window)
        vim.cmd("FloatermShow " .. name)
        vim.cmd("FloatermUpdate --position=" .. position .. " --width=0.45 --height=0.45")
      end
    end
    
    -- Main keymaps: Create or Focus
    vim.keymap.set("n", "<leader>t1", function() focus_terminal("term1", "top-left") end, 
      { desc = "Focus terminal 1" })
    vim.keymap.set("n", "<leader>t2", function() focus_terminal("term2", "top-right") end, 
      { desc = "Focus terminal 2" })
    vim.keymap.set("n", "<leader>t3", function() focus_terminal("term3", "bottom-left") end, 
      { desc = "Focus terminal 3" })
    vim.keymap.set("n", "<leader>t4", function() focus_terminal("term4", "bottom-right") end, 
      { desc = "Focus terminal 4" })

    -- Toggle (show/hide) specific terminals
    vim.keymap.set("n", "<leader>tt1", "<cmd>FloatermToggle term1<cr>", { desc = "Toggle terminal 1" })
    vim.keymap.set("n", "<leader>tt2", "<cmd>FloatermToggle term2<cr>", { desc = "Toggle terminal 2" })
    vim.keymap.set("n", "<leader>tt3", "<cmd>FloatermToggle term3<cr>", { desc = "Toggle terminal 3" })
    vim.keymap.set("n", "<leader>tt4", "<cmd>FloatermToggle term4<cr>", { desc = "Toggle terminal 4" })
    
    -- Generic new terminal (for extras)
    vim.keymap.set("n", "<leader>tn", "<cmd>FloatermNew<cr>", { desc = "New extra terminal" })
    
    -- List all terminals
    vim.keymap.set("n", "<leader>tl", "<cmd>Floaterms<cr>", { desc = "List all terminals" })
    
    -- Kill specific terminals
    vim.keymap.set("n", "<leader>tk1", "<cmd>FloatermKill term1<cr>", { desc = "Kill terminal 1" })
    vim.keymap.set("n", "<leader>tk2", "<cmd>FloatermKill term2<cr>", { desc = "Kill terminal 2" })
    vim.keymap.set("n", "<leader>tk3", "<cmd>FloatermKill term3<cr>", { desc = "Kill terminal 3" })
    vim.keymap.set("n", "<leader>tk4", "<cmd>FloatermKill term4<cr>", { desc = "Kill terminal 4" })
    
    -- Movement (inside terminal)
    vim.keymap.set("t", "<C-h>", "<cmd>FloatermUpdate --position=top-left<cr>")
    vim.keymap.set("t", "<C-l>", "<cmd>FloatermUpdate --position=top-right<cr>")
    vim.keymap.set("t", "<C-k>", "<cmd>FloatermUpdate --position=top<cr>")
    vim.keymap.set("t", "<C-j>", "<cmd>FloatermUpdate --position=bottom<cr>")
    vim.keymap.set("t", "<C-c>", "<cmd>FloatermUpdate --position=center<cr>")
  end,
}
