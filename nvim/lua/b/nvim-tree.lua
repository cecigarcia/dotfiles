local tree_cb = require "nvim-tree.config".nvim_tree_callback

vim.g.nvim_tree_highlight_opened_files = 0
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_disable_window_picker = 0
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_ignore = {"node_modules", ".DS_Store"}

vim.g.nvim_tree_icons = {
  git = {
    unstaged = "-"
  }
}

vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 0,
  folder_arrows = 1
}

vim.g.nvim_tree_special_files = {}

require("nvim-tree").setup {
  auto_close = false,
  view = {
    width = 30,
    mappings = {
      custom_only = true,
      list = {
        {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")},
        {key = "C", cb = tree_cb("cd")},
        {key = "P", cb = tree_cb("parent_node")},
        {key = "x", cb = tree_cb("close_node")},
        {key = "H", cb = tree_cb("toggle_ignored")},
        {key = "I", cb = tree_cb("toggle_dotfiles")},
        {key = "R", cb = tree_cb("refresh")},
        {key = "ma", cb = tree_cb("create")},
        {key = "md", cb = tree_cb("remove")},
        {key = "mm", cb = tree_cb("rename")},
        {key = "mx", cb = tree_cb("cut")},
        {key = "mc", cb = tree_cb("copy")},
        {key = "mp", cb = tree_cb("paste")},
        {key = "y", cb = tree_cb("copy_name")},
        {key = "Y", cb = tree_cb("copy_path")},
        {key = "gy", cb = tree_cb("copy_absolute_path")},
        {key = "?", cb = tree_cb("toggle_help")}
      }
    },
    side = "left"
  }
}

map("<leader>p", [[:NvimTreeToggle<cr>]], S)
map("-", [[:NvimTreeFind<cr>]], S)
