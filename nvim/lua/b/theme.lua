require("lsp-colors").setup {
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
}

vim.cmd [[
  syntax enable
  " colorscheme jellybeans
  colorscheme iceberg

  highlight NonText guifg=#f37711
  highlight SpecialKey guifg=#f37711
  highlight ExtraWhitespace guifg=#f3711 guibg=#000000
  highlight link TelescopeSelectionCaret TelescopeMultiSelection
  highlight TelescopeBorder guifg=#666666
]]
