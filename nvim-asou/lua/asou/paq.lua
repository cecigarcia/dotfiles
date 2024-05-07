require "paq" {
  "savq/paq-nvim",
  "pgilad/vim-react-proptypes-snippets",
  "honza/vim-snippets",
  "haya14busa/vim-asterisk",
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "vim-scripts/vim-indent-object",
  "tpope/vim-repeat",
  "vim-scripts/L9",
  "kana/vim-textobj-user",
  "kana/vim-textobj-line",
  {"nelstrom/vim-textobj-rubyblock", opt = true},
  "tpope/vim-ragtag",
  "tpope/vim-unimpaired",
  "tpope/vim-endwise",
  "tpope/vim-abolish",
  "sjl/clam.vim",
  "tpope/vim-dispatch",
  "tpope/vim-commentary",
  {"tpope/vim-jdaddy", opt = true},
  "tpope/vim-eunuch",
  -- {"shime/vim-livedown", opt = true},
  "tommcdo/vim-exchange",
  "duggiefresh/vim-easydir",
  "bronson/vim-trailing-whitespace",
  "rking/ag.vim",
  "jszakmeister/vim-togglecursor",
  "brooth/far.vim",
  "tweekmonster/startuptime.vim",
  "junegunn/vim-easy-align",
  "kana/vim-niceblock",
  {"godlygeek/tabular", opt = true},
  "wincent/vcs-jump",
  "jreybert/vimagit",
  "rstacruz/vim-closer",
  "AndrewRadev/splitjoin.vim",
  "hrsh7th/nvim-compe",
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  {"nvim-telescope/telescope-fzf-native.nvim", build = "make"},
  "nvim-telescope/telescope-fzf-writer.nvim",
  -- run TSUpdate
  {"nvim-treesitter/nvim-treesitter"},
  "nvim-treesitter/playground",
  "neovim/nvim-lspconfig",
  "tami5/lspsaga.nvim",
  "RishabhRD/popfix",
  "RishabhRD/nvim-lsputils",
  "wincent/pinnacle",
  "tjdevries/nlua.nvim",
  "camspiers/snap",
  "folke/lsp-colors.nvim",
  "folke/trouble.nvim",
  "norcalli/nvim-colorizer.lua",
  "phaazon/hop.nvim",
  "mhartington/formatter.nvim",
  "hoob3rt/lualine.nvim",
  "SirVer/ultisnips",
  "mattn/emmet-vim",
  "vimwiki/vimwiki",
  -- "Valloric/MatchTagAlways",
  "mhinz/vim-signify",
  "alvan/vim-closetag",
  "wincent/terminus",
  "AndrewRadev/tagalong.vim",
  "rhysd/vim-grammarous",
  "metakirby5/codi.vim",
  "kyazdani42/nvim-web-devicons",
  "folke/twilight.nvim",
  "sunjon/shade.nvim",
  "ray-x/lsp_signature.nvim",
  "mizlan/iswap.nvim",
  "kshenoy/vim-signature",
  -- color themes:
  "ishan9299/nvim-solarized-lua",
  "mhartington/oceanic-next",
  "arcticicestudio/nord-vim",
  "cocopon/iceberg.vim",
  "kyazdani42/nvim-tree.lua",
  "Pocco81/TrueZen.nvim",
  "folke/zen-mode.nvim"
}

vim.cmd [[autocmd Filetype ruby packadd! vim-textobj-rubyblock]]
vim.cmd [[autocmd Filetype markdown,md,pandoc packadd! vim-livedown]]
vim.cmd [[autocmd Filetype markdown,md,pandoc packadd! tabular]]
vim.cmd [[autocmd Filetype javascript,javascriptreact,json,js,jsx packadd! vim-jdaddy]]
vim.cmd [[autocmd Filetype javascript,javascriptreact,html,ejs,jsx,js,erb,xml,xhtml packadd! MatchTagAlways]]
vim.cmd [[autocmd Filetype javascript,javascriptreact,html,ejs,jsx,js,erb,xml,xhtml packadd! vim-closetag]]

-- UltiSnips
vim.g.UltiSnipsSnippetDirectories = {_G.os.getenv("HOME") .. "/.vim/Ultisnips"}
vim.g.UltiSnipsExpandTrigger = "<c-k>"
vim.g.UltiSnipsJumpForwardTrigger = "<c-k>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"

vim.cmd [[
augroup UltiSnipsCustomization
  autocmd!
  autocmd FileType javascript,javascriptreact,typescript,typescriptreact UltiSnipsAddFiletypes javascript.javascriptreact.typescript.typescriptreact
augroup END
]]

-- fzf
vim.g.fzf_command_prefix = "Fzf"
vim.g.fzf_action = {
  ["ctrl-t"] = "tab split",
  ["ctrl-x"] = "split",
  ["ctrl-s"] = "split",
  ["ctrl-v"] = "vsplit"
}

vim.g.fzf_layout = {window = {width = 1, height = 0.8, border = "sharp", yoffset = 1}}
vim.g.fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
vim.g.fzf_history_dir = "~/.local/share/fzf-history"
vim.g.fzf_preview_window = {"right:hidden", "ctrl-u"}

vim.g.fzf_colors = {
  fg = {"fg", "Normal"},
  bg = {"bg", "Normal"},
  hl = {"fg", "Comment"},
  ["fg+"] = {"fg", "CursorLine", "CursorColumn", "Normal"},
  ["bg+"] = {"bg", "CursorLine", "CursorColumn"},
  ["hl+"] = {"fg", "Statement"},
  info = {"fg", "PreProc"},
  border = {"fg", "Ignore"},
  prompt = {"fg", "Conditional"},
  pointer = {"fg", "Exception"},
  marker = {"fg", "Keyword"},
  spinner = {"fg", "Label"},
  header = {"fg", "Comment"}
}

-- emmet
vim.guser_emmet_settings = {
  javascript = {
    extends = "jsx"
  }
}

-- vimwiki
vim.g.vimwiki_conceallevel = 0
vim.g.vimwiki_url_maxsave = 0
vim.g.vimwiki_list = {{path = "~/.vimwiki/", path_html = "~/.vimwiki_html/"}}
vim.g.vimwiki_key_mappings = {
  all_maps = 1,
  global = 1,
  headers = 1,
  text_objs = 1,
  table_format = 1,
  table_mappings = 1,
  lists = 1,
  links = 0,
  html = 1,
  mouse = 0
}

-- MatchTagAlways
vim.g.mta_filetypes = {
  ejs = 1,
  html = 1,
  xhtml = 1,
  xml = 1,
  jinja = 1,
  eruby = 1
}
vim.g.mta_use_matchparen_group = 0
vim.g.mta_set_default_matchtag_color = 1
vim.cmd [[
highlight MatchTag ctermfg=black ctermbg=lightgreen guifg=black guibg=lightgreen
highlight MatchParen ctermfg=black ctermbg=lightgreen guifg=black guibg=lightgreen
]]

-- signify
vim.g.signify_sign_change = "~"
vim.g.signify_sign_show_count = 0
vim.g.signify_sign_show_text = 1

-- closetag
vim.g.closetag_filenames = "*.html,*.ejs,*.erb,*.jsx,*.js"

-- Terminus
vim.g.TerminusFocusReporting = 1
vim.g.TerminusBracketedPaste = 0

-- tagalong
vim.g.tagalong_additional_filetypes = {"javascript.jsx"}
