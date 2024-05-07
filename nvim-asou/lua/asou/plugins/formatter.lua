local prettierFormatting = function()
  local exe = vim.fn.exists("g:PrettierCommand") == 1 and vim.g.PrettierCommand or "./node_modules/.bin/prettier"

  local args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)}

  if vim.fn.exists("g:PrettierConfig") == 1 then
    table.insert(args, "--config")
    table.insert(args, vim.g.PrettierConfig)
  end

  return {
    exe = exe,
    args = args,
    stdin = true
  }
end

require("formatter").setup(
  {
    logging = true,
    filetype = {
      javascript = {prettierFormatting},
      javascriptreact = {prettierFormatting},
      typescript = {prettierFormatting},
      typescriptreact = {prettierFormatting},
      ["javascript.jsx"] = {prettierFormatting},
      css = {prettierFormatting},
      lua = {
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

vim.api.nvim_exec(
  [[
augroup Formatter
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.lua,*.ts,*.tsx silent! FormatWrite
augroup END
]],
  true
)
