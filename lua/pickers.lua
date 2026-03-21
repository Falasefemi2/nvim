local M = {}

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO)
end

local function select(items, opts, on_choice)
  if not items or #items == 0 then
    notify("No items to pick from")
    return
  end

  vim.ui.select(items, opts or {}, function(choice)
    if choice ~= nil then on_choice(choice) end
  end)
end

local function safe_require(mod)
  local ok, m = pcall(require, mod)
  if not ok then
    notify("Failed to load " .. mod, vim.log.levels.ERROR)
    return nil
  end
  return m
end

local function systemlist(cmd)
  local output = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then return nil, output end
  return output
end

local function format_path(path)
  if not path or path == "" then return "[No Name]" end
  return vim.fn.fnamemodify(path, ":.")
end

M.find_files = function()
  local fff = safe_require("fff")
  if not fff then return end
  fff.find_files()
end

M.find_all_files = function()
  local fff = safe_require("fff")
  if not fff then return end
  fff.find_files()
end

M.live_grep = function()
  local fff = safe_require("fff")
  if not fff then return end
  fff.live_grep()
end

M.buffers = function()
  local items = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buflisted then
      local name = vim.api.nvim_buf_get_name(buf)
      local display = format_path(name)
      table.insert(items, { buf = buf, name = name, display = display })
    end
  end

  select(items, {
    prompt = "Buffers",
    format_item = function(item) return item.display end,
  }, function(item)
    if vim.api.nvim_buf_is_valid(item.buf) then
      vim.api.nvim_set_current_buf(item.buf)
    end
  end)
end

M.oldfiles = function()
  local files = {}
  for _, file in ipairs(vim.v.oldfiles or {}) do
    if vim.fn.filereadable(file) == 1 then table.insert(files, file) end
  end

  select(files, {
    prompt = "Recent Files",
    format_item = format_path,
  }, function(file)
    vim.cmd("edit " .. vim.fn.fnameescape(file))
  end)
end

M.help_tags = function()
  local tags = vim.fn.getcompletion("", "help")
  select(tags, { prompt = "Help" }, function(tag)
    vim.cmd("help " .. tag)
  end)
end

M.marks = function()
  local items = {}

  local function add_marks(list, is_buf)
    for _, m in ipairs(list or {}) do
      local pos = m.pos or {}
      local bufnr = pos[1]
      local lnum = pos[2] or 1
      local col = (pos[3] or 0) + 1
      local file = m.file or ""

      if file == "" and is_buf and bufnr and bufnr > 0 then
        file = vim.api.nvim_buf_get_name(bufnr)
      end

      local display = string.format("%s %s:%d:%d", m.mark, format_path(file), lnum, col)
      table.insert(items, {
        mark = m.mark,
        file = file,
        lnum = lnum,
        col = col,
        display = display,
      })
    end
  end

  add_marks(vim.fn.getmarklist(), false)
  add_marks(vim.fn.getmarklist(vim.api.nvim_get_current_buf()), true)

  select(items, {
    prompt = "Marks",
    format_item = function(item) return item.display end,
  }, function(item)
    if item.file and item.file ~= "" then
      vim.cmd("edit " .. vim.fn.fnameescape(item.file))
    end
    vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
  end)
end

M.current_buffer_find = function()
  vim.ui.input({ prompt = "Search in buffer: " }, function(query)
    if not query or query == "" then return end
    local found = vim.fn.search(query, "W")
    if found == 0 then notify("No matches for: " .. query) end
  end)
end

M.git_status = function()
  if vim.fn.executable("git") ~= 1 then
    notify("git not found in PATH", vim.log.levels.ERROR)
    return
  end

  local output = systemlist("git status --porcelain")
  if not output then
    notify("Not a git repository", vim.log.levels.WARN)
    return
  end

  local items = {}
  for _, line in ipairs(output) do
    if line ~= "" then
      local status = line:sub(1, 2)
      local file = vim.trim(line:sub(4))
      local arrow = file:match("->%s*(.+)$")
      if arrow then file = arrow end
      table.insert(items, { status = status, file = file, display = status .. " " .. file })
    end
  end

  select(items, {
    prompt = "Git Status",
    format_item = function(item) return item.display end,
  }, function(item)
    if item.file and item.file ~= "" then
      vim.cmd("edit " .. vim.fn.fnameescape(item.file))
    end
  end)
end

M.git_commits = function()
  if vim.fn.executable("git") ~= 1 then
    notify("git not found in PATH", vim.log.levels.ERROR)
    return
  end

  local output = systemlist("git log --oneline --decorate -n 200")
  if not output then
    notify("Not a git repository", vim.log.levels.WARN)
    return
  end

  local items = {}
  for _, line in ipairs(output) do
    local hash, msg = line:match("^(%S+)%s+(.*)$")
    if hash and msg then
      table.insert(items, { hash = hash, msg = msg, display = hash .. " " .. msg })
    end
  end

  select(items, {
    prompt = "Git Commits",
    format_item = function(item) return item.display end,
  }, function(item)
    local show = systemlist("git show --stat " .. item.hash)
    if not show then
      notify("Failed to show commit " .. item.hash, vim.log.levels.ERROR)
      return
    end

    vim.cmd("new")
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(buf, "git:" .. item.hash)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, show)
    vim.bo[buf].modifiable = false
  end)
end

M.terms = function()
  local items = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      local name = vim.api.nvim_buf_get_name(buf)
      local display = name ~= "" and name or ("terminal:" .. buf)
      table.insert(items, { buf = buf, display = display })
    end
  end

  select(items, {
    prompt = "Terminals",
    format_item = function(item) return item.display end,
  }, function(item)
    if vim.api.nvim_buf_is_valid(item.buf) then
      vim.api.nvim_set_current_buf(item.buf)
      vim.cmd "startinsert"
    end
  end)
end

M.themes = function()
  local ok, nvchad_themes = pcall(require, "nvchad.themes")
  if ok and type(nvchad_themes.open) == "function" then
    nvchad_themes.open()
    return
  end

  local ok_utils, nvchad_utils = pcall(require, "nvchad.utils")
  local colors = ok_utils and nvchad_utils.list_themes() or vim.fn.getcompletion("", "color")
  local items = {}
  local seen = {}
  local current = require("nvconfig").base46.theme or vim.g.colors_name

  for _, color in ipairs(colors) do
    if color ~= "" and not seen[color] then
      seen[color] = true
      table.insert(items, {
        name = color,
        display = color == current and (color .. " [current]") or color,
      })
    end
  end

  table.sort(items, function(a, b)
    return a.name < b.name
  end)

  select(items, {
    prompt = "Themes",
    format_item = function(item) return item.display end,
  }, function(item)
    local previous = require("nvconfig").base46.theme or vim.g.colors_name
    local ok_apply, err = pcall(function()
      if ok_utils then
        require("nvconfig").base46.theme = item.name
        require("base46").load_all_highlights()
        package.loaded.chadrc = nil
        local old_theme = require("chadrc").base46.theme
        nvchad_utils.replace_word('theme = "' .. old_theme, 'theme = "' .. item.name)
      else
        vim.cmd.colorscheme(item.name)
      end
    end)
    if not ok_apply then
      if previous and previous ~= "" and previous ~= item.name then
        if ok_utils then
          pcall(function()
            require("nvconfig").base46.theme = previous
            require("base46").load_all_highlights()
          end)
        else
          pcall(vim.cmd.colorscheme, previous)
        end
      end
      notify("Failed to load colorscheme " .. item.name .. ": " .. err, vim.log.levels.ERROR)
    end
  end)
end

return M
