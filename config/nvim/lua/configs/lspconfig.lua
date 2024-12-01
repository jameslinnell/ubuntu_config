-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "pyright" }
local nvlsp = require "nvchad.configs.lspconfig"

-- Helper function to get the Python path from `.venv`
local function get_python_path()
  local venv = vim.fn.getcwd() .. "/.venv/bin/python"
  if vim.fn.filereadable(venv) == 1 then
    return venv
  else
    return "python"  -- Fallback to system python if .venv is not found
  end
end

-- LSPs with default config and customized Python path
for _, lsp in ipairs(servers) do
  if lsp == "pyright" then
    lspconfig[lsp].setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      settings = {
        python = {
          pythonPath = get_python_path()
        }
      }
    }
  else
    lspconfig[lsp].setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  end
end
-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
