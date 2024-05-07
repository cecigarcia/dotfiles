local trim = require("vendor/trim")

local prettierFormatting = function()
  local exe = "prettier"

  if vim.fn.filereadable("./node_modules/.bin/prettier") == 1 then
    exe = "./node_modules/.bin/prettier"
  end

  if _G.CustomConfig.prettier_command then
    exe = trim(_G.CustomConfig.prettier_command)
  end

  local args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) };

  if _G.CustomConfig.prettier_config then
    table.insert(args, "--config");
    table.insert(args, trim(_G.CustomConfig.prettier_config));
  end

  return {
    exe = exe,
    args = args,
    stdin = true
  }
end

require('formatter').setup({
  logging = false,

  filetype = {
    javascript = { prettierFormatting },
    javascriptreact = { prettierFormatting },
    typescript = { prettierFormatting },
    typescriptreact = { prettierFormatting },
    json = { prettierFormatting },
    css = { prettierFormatting },
  },
})

vim.cmd [[
  aug b_formatter
    au!
    au BufWritePost *.json,*.js,*.cjs,*.mjs,*.jsx,*.ts,*.tsx,*.css silent! FormatWrite
  aug END
]]
