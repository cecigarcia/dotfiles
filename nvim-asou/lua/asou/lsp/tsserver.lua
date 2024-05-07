local nvim_lsp = require("lspconfig")
local utils = require "asou/lsp/utils"

local on_attach = utils.on_attach
local root = utils.root

_G.lsp_organize_imports = function()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_highlight = true
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,
  root_dir = root(".git")
}
