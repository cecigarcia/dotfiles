function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

--local theme = require "asou.theme"
require "asou.paq"
require "asou.plugins"
require "asou.lsp"
require "asou.settings"
require "asou.mappings"

--theme.setBg("dark")

--require "paq" {
  --"tpope/vim-surround"
--}
