local colors = {
  light = {
    white = "#33374c",
    black = "#d2d4dd",
    red = "#cc3768",
    orange = "#c57339",
    blue = "#2d539e",
    green = "#598030"
  },
  dark = {
    white = "#d2d4de",
    black = "#1e2132",
    red = "#e27878",
    orange = "#e9b189",
    blue = "#84a0c6",
    green = "#b4be82"
  }
}

local function setupTheme(bg, currentPalette)
  vim.opt.background = bg
  vim.cmd [[
  syntax enable
  colorscheme iceberg
]]

  vim.cmd([[let g:terminal_color_BUFFER_BG =']] .. currentPalette.Background .. [[']])

  -- Keep the signcolumn background the same as the rest of
  -- the buffer
  --
  -- This should work using the g:terminal_color_0 variable,
  -- but... it doesn't
  vim.cmd [[

  execute('highlight SignColumn cterm=NONE gui=NONE  guibg=' . g:terminal_color_BUFFER_BG)
]]

  vim.cmd [[
  execute('highlight SignifySignAdd cterm=NONE gui=NONE  guifg=' . g:terminal_color_2)
  execute('highlight SignifySignDelete cterm=NONE gui=NONE  guifg=' . g:terminal_color_1)
  execute('highlight SignifySignChange cterm=NONE gui=NONE  guifg=' . g:terminal_color_6)
]]

  vim.cmd [[
  execute('highlight SignatureMarkText cterm=NONE gui=NONE guifg=' . g:terminal_color_3 . ' guibg=' .g:terminal_color_BUFFER_BG)
]]

  -- nvim tree
  vim.cmd [[
  execute('highlight NvimTreeFileDirty cterm=NONE gui=NONE  guifg=' . g:terminal_color_2)
]]
end

local bg = "dark"

local listeners = {}

local M = {}

M.currentBg = function()
  return bg
end

M.addListener = function(l)
  table.insert(listeners, l)
end

M.currentColors = function()
  local currentPalette = colors[bg]

  return {
    raw = currentPalette,
    Text = currentPalette.white,
    Background = currentPalette.black,
    Error = currentPalette.red,
    Warning = currentPalette.orange,
    Information = currentPalette.blue,
    Hint = currentPalette.green
  }
end

local function notifyListeners()
  for _, l in pairs(listeners) do
    l()
  end
end

M.setBg = function(val)
  bg = val
  setupTheme(val, M.currentColors())
  notifyListeners()
end

M.setBg(bg)

_G.asou = {
  setBg = M.setBg
}

vim.cmd("command! AsouColorDark call v:lua.asou.setBg('dark')")
vim.cmd("command! AsouColorLight call v:lua.asou.setBg('light')")

return M
