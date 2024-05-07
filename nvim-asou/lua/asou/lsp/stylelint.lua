local nvim_lsp = require("lspconfig")
local utils = require "asou/lsp/utils"

local on_attach = utils.on_attach

nvim_lsp.stylelint_lsp.setup {
  settings = {
    stylelintplus = {
      autoFixOnSave = true,
      autoFixOnFormat = true
    }
  },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end
}
