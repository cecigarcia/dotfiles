local utils = require "asou.utils"
local map = utils.map

-- custom stuff
map("n", "<Leader><Leader>", ":", {noremap = true, silent = true})

-- telescope
map("n", "<c-p>", ":Telescope find_files disable_devicons=true<cr>")
map("n", "<leader>A", "<cmd>Telescope live_grep disable_devicons=true<cr>")
map("n", "<leader>w", "<cmd>Telescope grep_string disable_devicons=true<cr>")
map("n", "<leader>b", "<cmd>Telescope buffers disable_devicons=true<cr>")
map("n", "<leader>h", "<cmd>Telescope help_tags disable_devicons=true<cr>")
map("n", "<leader>H", ":lua require'asou.plugins.telescope'.help_cword()<cr>")
map("n", "<leader>w", ":lua require'asou.plugins.telescope'.search_wiki()<cr>")
map("n", "<c-s>", "<cmd>Telescope lsp_dynamic_workspace_symbols disable_devicons=true<cr>")

vim.cmd [[
  call misc#commandAlias("T","Telescope")
  call misc#commandAlias("Tmaps","Telescope keymaps")
  call misc#commandAlias("Tts","Telescope treesitter")
  call misc#commandAlias("Tt","Telescope treesitter")
  call misc#commandAlias("Ts","Telescope lsp_dynamic_workspace_symbols")
]]

-- complete with compe
map("i", "<c-space>", "compe#complete()", {expr = true, silent = true})
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- hop to char
map("n", "s", "<cmd>lua require'hop'.hint_char1()<cr>", {})

-- command mode (:) history search
vim.cmd [[
cmap <C-R> <Plug>(TelescopeFuzzyCommandSearch)
]]

-- Disable Ex mode
map("n", "Q", "<nop>")

-- open tab for snippets edition
map("n", "<leader>es", ":tabedit ~/.vim/custom_snippets/<cr>", {silent = true})

-- cycle through windows
map("n", "<tab>", ":wincmd w<cr>", {silent = true})
map("n", "<s-tab>", ":wincmd W<cr>", {silent = true})

-- <c-i> jumps forward, but <c-i> and <tab> are just the same key for Vim. So,
-- in order to get back the jumping shiat, now as <c-l>, here comes a remap:
map("n", "<c-l>", "<c-i>")

-- word under cursor substitution
map("n", "<leader>S", [[:%s/<c-r>=expand("<cword>")<cr>//gc<left><left><left>]], {silent = true})

-- split line
map("n", "S", [[:keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>]], {silent = true})

-- Visual select all
map("n", "<leader>a", "ggVG", {silent = true})

--visual select most recently edited text
map("n", "gV", "`[v`]", {noremap = false})

--clear search highlights
map("n", "<backspace>", ":nohlsearch<CR>:cclose<CR>", {silent = true})

--Fix some movements
map("n", "j", "gj")
map("n", "k", "gk")

-- Fix gx for opening URLs
vim.cmd [[
function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!open '".s:uri."'"
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>
]]

--repeat last macro
map("n", "<space>", "@@", {silent = true})

-- sjl goodies {{{
-- Zip Right
map("n", "zl", [[:let @z=@"<cr>x$p:let @"=@z<cr>]])

-- Made D behave
map("n", "D", "d$")

-- Keep search matches in the middle of the window.
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Same when jumping around
map("n", "g;", "g;zz")
map("n", "g,", "g,zz")
map("n", "<c-o>", "<c-o>zz")

-- Easier to type, and I never use the default behavior.
map("n", "H", "^")
map("n", "L", "g_")

-- Emacs bindings
map("c", "<c-a>", "<home>")
map("c", "<c-e>", "<end>")
map("i", "<c-a>", "<esc>I")
map("i", "<c-e>", "<esc>A")

-- gi already moves to "last place you exited insert mode", so we'll map gI to
-- something similar: move to last change
map("n", "gI", "`.")

-- }}} sjl goodies

-- some movements
-- Original vim mappings:
map("n", "*", "<Plug>(asterisk-z*)", {noremap = false})
map("n", "#", "<Plug>(asterisk-z#)", {noremap = false})
map("n", "g*", "<Plug>(asterisk-gz*)", {noremap = false})
map("n", "g#", "<Plug>(asterisk-gz#)", {noremap = false})

map("n", [[<leader>"]], [[ysiw"E]], {noremap = false})
map("n", "<leader>'", "ysiw'E", {noremap = false})
map("n", "<leader>[", "ysiw]E", {noremap = false})
map("n", "<leader>]", "ysiw]E", {noremap = false})
map("n", "<leader>(", "ysiw)E", {noremap = false})
map("n", "<leader>)", "ysiw)E", {noremap = false})
map("n", "<leader>_", "ysiw_E", {noremap = false})
map("n", "<leader>`", "ysiw`<Esc>E", {noremap = false})

map("n", "]c", "<plug>(signify-next-hunk)", {noremap = false})
map("n", "[c", "<plug>(signify-prev-hunk)", {noremap = false})

-- Shortcuts to some files
map("n", "<leader>ev", ":tabedit ~/.vimrc<CR>")
map("n", "<leader>sv", ":source ~/.vimrc<CR>")
map("n", "<leader>ez", ":tabedit ~/.zshrc<CR>")
map("n", "<leader>ef", ":tabedit ~/.config/fish/config.fish<CR>")
map("n", "<leader>et", ":tabedit ~/.tmux.conf<CR>")
map("n", "<leader>eg", ":tabedit ~/.gitconfig<CR>")
map("n", "<leader>ek", ":tabedit ~/.config/kitty/kitty.conf<CR>")

-- rest.nvim
vim.cmd [[
  command! Rest :lua require('rest-nvim').run()<cr>
]]

-- nvim_tree
vim.cmd [[
function! OpenTree()
  let readable = filereadable(bufname(expand('%:p')))

  if readable
    execute 'NvimTreeFindFile'
  else
    execute 'NvimTreeToggle'
  endif
endfunction
]]

map("n", "<leader>p", ":call OpenTree()<CR>", {silent = true})
