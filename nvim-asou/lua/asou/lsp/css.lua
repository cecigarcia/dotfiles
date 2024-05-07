local nvim_lsp = require("lspconfig")
local utils = require "asou/lsp/utils"

local on_attach = utils.on_attach
local root = utils.root

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.cssls.setup {
  capabilities = capabilities,
  root_dir = root(".git"),
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
    on_attach(client, bufnr)
  end
}
