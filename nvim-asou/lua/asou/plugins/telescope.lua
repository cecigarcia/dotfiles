local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")

local custom_actions = {}

function custom_actions.fzf_multi_select(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = table.getn(picker:get_multi_selection())

  if num_selections > 1 then
    -- actions.file_edit throws - context of picker seems to change
    --actions.file_edit(prompt_bufnr)
    actions.send_selected_to_qflist(prompt_bufnr)
    actions.open_qflist()
  else
    actions.file_edit(prompt_bufnr)
  end
end

local normal_mappings = {
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

require("telescope").setup {
  defaults = {
    -- use fzy???
    -- file_sorter = require'telescope.sorters'.get_fzy_sorter,
    -- generic_sorter = require'telescope.sorters'.get_fzy_sorter,
    find_command = {"rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case"},
    borderchars = {
      {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
      results = {"─", "│", " ", "│", "┌", "┐", "│", "│"},
      prompt = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
      preview = {"─", "│", "─", "│", "┌", "┐", "┘", "└"}
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<cr>"] = custom_actions.fzf_multi_select
      },
      n = {
        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<cr>"] = custom_actions.fzf_multi_select
      }
    }
  },
  pickers = {
    help_tags = {
      mappings = normal_mappings
    },
    buffers = {previewer = false},
    lsp_document_symbols = {symbol_width = 100}
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true
    },
    fzf_writer = {
      minimum_grep_characters = 2,
      minimum_files_characters = 2,
      use_highlighter = true
    }
  }
}

require("telescope").load_extension("fzf")

local M = {}

function M.search_wiki()
  builtin.live_grep {
    prompt_title = "Search wiki",
    shorten_path = false,
    cwd = "~/Dropbox/vimwiki"
  }
end

function M.help_cword()
  builtin.help_tags {
    search = "hi",
    prompt_title = "Help",
    shorten_path = false,
    mappings = normal_mappings
  }
end

function M.project_files()
  require("telescope").extensions.fzf_writer.files()
  -- local ok = pcall(builtin.git_files)
  -- if not ok then
  --   builtin.find_files()
  -- end
end

return M
