local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")

local custom_actions = {
  multi_select = function(prompt_bufnr)
    local picker = actions_state.get_current_picker(prompt_bufnr)
    local num_selections = table.getn(picker:get_multi_selection())
    if num_selections > 1 then
      actions.send_selected_to_qflist(prompt_bufnr)
      actions.open_qflist()
    else
      actions.file_edit(prompt_bufnr)
    end
  end
}

require("telescope").setup {
  defaults = {
    color_devicons = false,
    use_less = false,
    file_ignore_patterns = { "~$", "node_modules/.*" },

    layout_config = {
      horizontal = {
        width = 0.8,
        height = 0.8,
        preview_width = function(_, cols) return math.floor(cols * 0.5) end,
      },
      vertical = {
        width = 0.6,
        height = 0.6,
      },
    },

    mappings = {
      n = {
       ["<C-x>"] = false,
       ["<C-v>"] = false,
       ["<C-t>"] = false,
       ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
       ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
       ["<cr>"] = custom_actions.multi_select
      },
      i = {
       ["<C-x>"] = false,
       ["<C-v>"] = false,
       ["<C-t>"] = false,
       ["<esc>"] = actions.close,
       ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
       ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
       ["<cr>"] = custom_actions.multi_select
      }
    },
  },

  pickers = {
    command_history = {
      layout_strategy = "vertical",
      previewer = false,
    },

    search_history = {
      layout_strategy = "vertical",
      previewer = false,
    },

    buffers = {
      layout_strategy = "vertical",
      previewer = false,
    },

    lsp_document_symbols = {
      layout_strategy = "vertical",
      previewer = false,
      mappings = {
        n = {
          ["<tab>"] = actions.move_selection_next,
          ["<s-tab>"] = actions.move_selection_previous,
          ["<cr>"] = actions.select_default
        },
        i = {
          ["<tab>"] = actions.move_selection_next,
          ["<s-tab>"] = actions.move_selection_previous,
          ["<cr>"] = actions.select_default
        }
      }
    },

    help_tags = {
      mappings = {
        n = {
          ["<tab>"] = actions.move_selection_next,
          ["<s-tab>"] = actions.move_selection_previous,
          ["<cr>"] = actions.select_default
        },
        i = {
          ["<tab>"] = actions.move_selection_next,
          ["<s-tab>"] = actions.move_selection_previous,
          ["<cr>"] = actions.select_default
        }
      }
    }
  }
}

map("<leader>F", [[:Telescope find_files disable_devicons=true<cr>]], S)
map("<leader>f", [[:Telescope git_files disable_devicons=true<cr>]], S)
map("<leader>b", [[:Telescope buffers disable_devicons=true<cr>]], S)
map("<leader>s", [[:Telescope lsp_document_symbols<cr>]], S)
map("<leader>/", [[:Telescope live_grep disable_devicons=true<cr>]], S)
map("<leader>*", [[:Telescope grep_string disable_devicons=true<cr>]], S)
map("<leader>:", [[:Telescope command_history<cr>]], S)
map("<leader>q", [[:Telescope quickfix disable_devicons=true<cr>]], S)
map("<leader>?", [[:Telescope help_tags<cr>]], S)
