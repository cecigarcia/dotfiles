-- https://github.com/hoob3rt/lualine.nvim/blob/master/lua/lualine/themes/jellybeans.lua
local ll_theme = require('lualine.themes.jellybeans')
local ll_theme = require('lualine.themes.iceberg_dark')

-- ll_theme.normal.a.bg = '#4e4e43'
-- ll_theme.normal.a.fg = '#abab9d'
-- ll_theme.insert.a.bg = '#f37711'
-- ll_theme.visual.a.bg = '#99ad6a'
-- ll_theme.normal.c.fg = '#abab9d'
-- ll_theme.inactive.c.fg = '#abab9d'

local ll_conditions = {
  named_buffer = function() return vim.bo.modifiable and  vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
  modifiable = function() return vim.bo.modifiable end,
}

local ll_c = {
  mode = {
    "mode",
    lower = true,
    condition = ll_conditions.modifiable
  },
  filename = {
    'filename',
    path = 1,
    file_status = false,
    condition = ll_conditions.named_buffer,
    color = { fg = "#b2b4bd" },
  },
  modified = {
    function()
      if vim.bo.modified then
        return  " "
      else
        return ''
      end
    end,
    color = { fg = "#d59b72" },
    padding_left = 1,
    padding_right = 0,
    condition = ll_conditions.modifiable
  },
  location = {
    "location",
    padding_right = 1,
    padding_left = 0,
    condition = ll_conditions.modifiable
  },
  diagnostics = {
    "diagnostics",
    condition = ll_conditions.modifiable,
    sources = { 'nvim_lsp' },
    sections = {'error', 'warn' },
    symbols = {
      error = " ",
      warn = " ",
    }
  }
}


require("lualine").setup {
  options = {
    icons_enabled = false,
    component_separators = {'', ''},
    section_separators = {'', ''},
    theme = ll_theme
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { ll_c.modified, ll_c.filename},
    lualine_x = { ll_c.diagnostics },
    lualine_y = {},
    lualine_z = { ll_c.mode, ll_c.location }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { ll_c.modified, ll_c.filename },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
}
