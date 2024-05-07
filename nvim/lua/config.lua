require("b.paq")

vim.o.backup = false
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.diffopt = vim.o.diffopt..',iwhite'
vim.o.expandtab = true
vim.o.exrc = true
vim.o.ffs = 'unix,dos,mac'
vim.o.hidden = true
vim.o.history = 1000
vim.o.ignorecase = true
vim.o.iskeyword = vim.o.iskeyword..",-"
vim.o.joinspaces = false
vim.o.lazyredraw = true
vim.o.list = true
vim.o.listchars = 'tab:▸ ,trail:·,nbsp:_'
vim.o.mouse = 'a'
vim.o.number = true
vim.o.scrolloff = 5
vim.o.secure = true
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.switchbuf = 'useopen'
vim.o.synmaxcol = 1000
vim.o.tabstop = 2
vim.o.whichwrap= 'b,s,l,h,<,>,~,[,]'
vim.o.wildignore = 'target/**,.bundle,node_modules/**,tmp/**'
vim.o.wildmode = 'list:longest'
vim.o.writebackup = false

if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

vim.g.mapleader = "ñ"

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

function _G.trim(s)
  return s:gsub("^%s+", ""):gsub("%s+$", "")
end

function _G.map(mapping, command, opts)
  vim.api.nvim_set_keymap("n", mapping, command, { noremap = true, silent = opts == "silent" or false })
end

_G.S = "silent"
_G.CustomConfig = {}

if vim.fn.filereadable(".editorconfig") == 1 then
  local LIP = require 'vendor/lip'
  local data = LIP.load(".editorconfig")
  if (data["nvim-custom"]) then
    _G.CustomConfig = data["nvim-custom"]
  end
end

require("b.treesitter")
require("b.lsp")
require("b.telescope")
require("b.nvim-tree")
require("b.lualine")
require("b.compe")
require("b.formatter")
require("b.colorizer")
require("b.theme")
require("b.more-stuff")
require("b.text-edit")
