local nvim_lsp = require "lspconfig"
local utils = require "asou/lsp/utils"

local root = utils.root
local on_attach = utils.on_attach

local filetypes = {
  typescript = "eslint",
  typescriptreact = "eslint",
  javascript = "eslint",
  javascriptreact = "eslint",
  ["javascript.jsx"] = "eslint",
  css = "stylelint"
}

nvim_lsp.diagnosticls.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,
  filetypes = vim.tbl_keys(filetypes),
  root_dir = root(".eslintrc.js", ".git"),
  init_options = {
    filetypes = filetypes,
    linters = {
      eslint = {
        command = "./node_modules/.bin/eslint",
        sourceName = "eslint",
        rootPatterns = {".eslintrc.js", ".git"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
        },
        securities = {
          [1] = "",
          [2] = "warning",
          [3] = "error"
        }
      },
      stylelint = {
        sourceName = "stylelint",
        command = "./node_modules/.bin/stylelint",
        args = {"--formatter", "compact", "%filepath"},
        rootPatterns = {".stylelintrc.js", ".git"},
        debounce = 100,
        formatPattern = {
          [[: line (\d+), col (\d+), (warning|error) - (.+?) \((.+)\)]],
          {
            line = 1,
            column = 2,
            security = 3,
            message = {4, " [", 5, "]"}
          }
        },
        securities = {
          warning = "warning",
          error = "error"
        }
      }
    }
  }
}
