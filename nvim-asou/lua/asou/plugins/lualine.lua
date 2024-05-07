local lualine = require "lualine"
local icebergDark = require "lualine.themes.iceberg_dark"
local icebergLight = require "lualine.themes.iceberg_light"
local theme = require "asou.theme"

local iceberg = {
  dark = icebergDark,
  light = icebergLight
}

local function setupLualine()
  local bg = theme.currentBg()
  local colors = theme.currentColors()

  local lualineThemeName = "iceberg_" .. bg

  local modes = {"inactive", "insert", "normal", "replace", "visual"}

  local function tweak_theme()
    for _, m in ipairs(modes) do
      iceberg[bg][m].a.gui = nil
      iceberg[bg][m].b.bg = colors.Background
      if (iceberg[bg][m].c) then
        if (m ~= "inactive") then
          iceberg[bg][m].c.fg = colors.Text
        end
        iceberg[bg][m].c.bg = colors.Background
      end
    end
  end

  tweak_theme()

  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand("%:p:h")
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end
  }

  local function mode()
    local mode_name = {
      [""] = "V",
      [""] = "S"
    }

    local name = mode_name[vim.fn.mode()] or vim.fn.mode()

    return string.sub(name, 1, 1)
  end

  local diagnostics = {
    "diagnostics",
    icons_enabled = false,
    sources = {"nvim_lsp"},
    symbols = {error = " ", warn = " ", info = " "},
    color_error = colors.red,
    color_warn = colors.yellow,
    color_info = colors.cyan
  }

  local function status_fn()
    if vim.bo.modified then
      return "●"
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
      return "🔒"
    end

    return " "
  end

  local status = {
    status_fn,
    color = {fg = colors.raw.red},
    left_padding = 1,
    right_padding = 0
  }

  local filename = {
    "filename",
    path = 1,
    file_status = false,
    condition = conditions.buffer_not_empty
  }

  -- Config
  local config = {
    options = {
      icons_enabled = true,
      theme = lualineThemeName,
      component_separators = {"", "", ""},
      section_separators = {"", ""},
      disabled_filetypes = {"help", "NvimTree"}
    },
    sections = {
      lualine_a = {mode},
      lualine_b = {filename},
      lualine_c = {status},
      lualine_x = {"filetype"},
      lualine_y = {diagnostics}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {status, filename},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  }

  lualine.setup(config)
end

theme.addListener(
  function()
    setupLualine()
  end
)
