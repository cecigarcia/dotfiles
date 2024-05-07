local lspColors = require("lsp-colors")
local theme = require "asou.theme"

local function setupLspColors()
  local colors = theme.currentColors()

  lspColors.setup(colors)
end

theme.addListener(
  function()
    setupLspColors()
  end
)
