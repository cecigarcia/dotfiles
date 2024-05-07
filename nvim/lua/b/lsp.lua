local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')
local trim = require('vendor/trim')

local mapx = function(type, key, value)
  vim.api.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true});
end

local on_attach = function(client, bufnr)
  -- TODO: Check this!
  mapx('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
  mapx('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
  mapx('n','rr','<cmd>lua vim.lsp.buf.rename()<CR>')
  mapx('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')

  protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  }
end

nvim_lsp.tsserver.setup {
  cmd = { "typescript-language-server", "--stdio" },

  filetypes = {
    "typescript",
    "typescriptreact",
  },

  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,

  root_dir = function() return vim.fn.getcwd() end
}

local eslint_exe

if vim.fn.filereadable("./node_modules/.bin/eslint") == 1 then
  eslint_exe = "./node_modules/.bin/eslint"
end

if _G.CustomConfig.eslint_command then
  eslint_exe = trim(_G.CustomConfig.eslint_command)
end

if eslint_exe then
  nvim_lsp.diagnosticls.setup {
    cmd = {"diagnostic-languageserver", "--stdio", "--log-level", "4"},

    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
    end,

    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },

    init_options = {
      filetypes = {
        javascript = "eslint",
        javascriptreact = "eslint",
        typescript = "eslint",
        typescriptreact = "eslint",
      },

      linters = {
        eslint = {
          sourceName = "eslint",
          command = eslint_exe,
          rootPatterns = { ".editorconfig", ".eslintrc", ".eslintrc.js" },
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
            [1] = "nope",
            [2] = "warning",
            [3] = "error",
          }
        }
      }
    }
  }
end

vim.cmd [[
  sign define LspDiagnosticsSignError text=
  sign define LspDiagnosticsSignWarning text=
  sign define LspDiagnosticsSignInformation text=
  sign define LspDiagnosticsSignHint text=
]]


require("trouble").setup {
  icons = false,
  use_lsp_diagnostic_signs = false,
  signs = {
    error = " ",
    warning = " ",
    hint = " ",
    information = " ",
    other = " "
  },
}

map("<leader>x", [[:TroubleToggle<cr>]], S)
