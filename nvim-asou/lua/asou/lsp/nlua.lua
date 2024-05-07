local utils = require "asou/lsp/utils"

local on_attach = utils.on_attach

require("nlua.lsp.nvim").setup(
  require("lspconfig"),
  {
    cmd = {
      "/Users/ceci/Software/lua-language-server/bin/macOS/lua-language-server",
      "-E",
      "/Users/ceci/Software/lua-language-server/main.lua"
    },
    on_attach = function(client, bufnr)
      -- require('completion').on_attach()

      local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
      end

      buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
      on_attach(client, bufnr)
    end
  }
)
