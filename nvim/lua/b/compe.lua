require "compe".setup {
  enabled = true,
  autocomplete = true,
  documentation = true,
  source = {
    path = true,
    buffer = true,
    calc = true,
    ultisnips = false,
    nvim_lsp = true,
    nvim_lua = true,
    spell = false,
    tags = false,
    treesitter = false
  }
}

vim.cmd [[
  inoremap <silent><expr> <C-Space> compe#complete()
  inoremap <silent><expr> <CR>      compe#confirm('<CR>')
]]


local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

function mapx(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

mapx("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
mapx("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
mapx("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
mapx("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
