vim.g.mapleader = "ñ"

vim.g.node_host_prog = "/Users/ceci/.nodenv/versions/16.13.1/bin/neovim-node-host"

local options = {
  -- set t_Co=256??
  autoindent = true,
  autoread = true,
  background = "dark",
  backspace = "start,eol,indent",
  backup = false,
  breakindent = true,
  clipboard = "unnamed", -- unnamedplus ??
  colorcolumn = "0",
  complete = ".,w,b,u,t,i",
  completeopt = "menu,menuone,noselect",
  concealcursor = "nc",
  conceallevel = 0,
  cursorline = true,
  equalalways = true,
  expandtab = true,
  exrc = true,
  fillchars = {vert = "▏"},
  foldcolumn = "0",
  foldlevel = 999,
  grepprg = [[ag\ --nogroup\ --nocolor]],
  hidden = true,
  hlsearch = true,
  ignorecase = true,
  incsearch = true,
  infercase = true,
  joinspaces = true,
  laststatus = 2,
  lazyredraw = true,
  linebreak = true,
  list = true,
  listchars = {nbsp = "⦸", tab = "▸\\", extends = "»", precedes = "«", trail = "•"},
  mouse = "a",
  number = false,
  numberwidth = 3,
  path = ".,src,node_nodules",
  scrolloff = 5,
  secure = true,
  shell = "/bin/sh",
  shiftround = true,
  shiftwidth = 2,
  shortmess = "aOTIWc",
  showmatch = true,
  showmode = false,
  showtabline = 1,
  signcolumn = "yes:2",
  smartcase = true,
  smartindent = true,
  softtabstop = 2,
  splitbelow = true,
  splitright = true,
  suffixesadd = ".js,.jsx",
  swapfile = false,
  switchbuf = "useopen",
  synmaxcol = 300,
  syntax = "on",
  tabstop = 2,
  tags = "tags,./tags,tags.coffee,./tags.coffee",
  termguicolors = true,
  ttyfast = true,
  updatetime = 500,
  virtualedit = "block",
  wildignore = "*.git,*.svn,*.class,target,.jhw-cache,.bundle,node_modules/**,.sass-cache,tmp/**",
  wildmenu = true,
  wrap = true,
  writebackup = false,
  wildmode = "list:longest,full"
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.opt.diffopt:append({"iwhite"})
vim.opt.whichwrap:append("b,s,l,h,<,>,~,[,]")
vim.opt.formatoptions:append({"vjn"})
vim.opt.formatoptions:remove({"l"})
vim.opt.iskeyword:remove(":")

-- TODO how to do this: gopt('omnifunc', syntaxcomplete#Complete)

-- Prevent Vim from clobbering the scrollback buffer. See
-- http://www.shallowsky.com/linux/noaltscreen.html
-- t_ti= t_te=

vim.g.ruby_path = _G.os.getenv("HOME") .. "/.rbenv/shims"

vim.gpython_host_prog = "/usr/bin/python"
vim.gpython3_host_prog = "/usr/local/bin/python3"
vim.g.markdown_fenced_languages = {"html", "vim", "ruby", "python", "bash=sh", "javascript", "javascriptreact"}
