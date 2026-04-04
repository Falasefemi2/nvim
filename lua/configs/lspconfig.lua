local defaults = require "nvchad.configs.lspconfig"

local base_config = {
  on_attach = defaults.on_attach,
  capabilities = defaults.capabilities,
}

local function extend(config)
  return vim.tbl_deep_extend("force", {}, base_config, config or {})
end

local function configure(server, config)
  vim.lsp.config(server, extend(config))
  vim.lsp.enable(server)
end

local function find_executable(names)
  for _, name in ipairs(names) do
    local executable = vim.fn.exepath(name)

    if executable ~= "" then
      return executable
    end

    local mason_executable = vim.fs.joinpath(vim.fn.stdpath "data", "mason", "bin", name)

    if vim.uv.fs_stat(mason_executable) then
      return mason_executable
    end
  end
end

configure("cssls")

configure("html", {
  filetypes = { "html" },
})

configure("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      gofumpt = true,
    },
  },
})

configure("ts_ls", {
  init_options = {
    plugins = {
      {
        name = "@effect/language-service",
        location = vim.fn.getcwd() .. "\\node_modules\\@effect\\language-service",
      },
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "none",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHints = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = false,
        includeInlayEnumMemberValueHints = false,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "none",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHints = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = false,
        includeInlayEnumMemberValueHints = false,
      },
    },
  },
})

configure("tailwindcss", {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
})

local emmet_executable = find_executable {
  "emmet-language-server.cmd",
  "emmet-language-server",
  "emmet-ls.cmd",
  "emmet-ls",
}

if emmet_executable then
  local emmet_server = emmet_executable:match "emmet%-ls" and "emmet_ls" or "emmet_language_server"

  configure(emmet_server, {
    cmd = { emmet_executable, "--stdio" },
    filetypes = {
      "html",
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
  })
end

configure("sqls", {
  filetypes = { "mysql" },
})

configure("postgres_lsp", {
  filetypes = { "sql" },
  root_markers = {
    "postgres-language-server.jsonc",
    ".git",
  },
})
