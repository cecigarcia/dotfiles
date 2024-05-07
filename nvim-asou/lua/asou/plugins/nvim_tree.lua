local nvim_tree = require("nvim-tree")

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return {desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true}
  end

  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
  vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
  vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
  vim.keymap.set("n", "x", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "go", api.node.open.preview, opts("Open Preview"))
  vim.keymap.set("n", "gf", api.node.run.system, opts("Open Preview"))
  vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
  vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
  vim.keymap.set("n", "ma", api.fs.create, opts("Create"))
  vim.keymap.set("n", "md", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "mr", api.fs.rename, opts("Rename"))
  vim.keymap.set("n", "mx", api.fs.cut, opts("Cut"))
  vim.keymap.set("n", "mc", api.fs.copy.node, opts("Copy"))
  vim.keymap.set("n", "mp", api.fs.paste, opts("Paste"))
  vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
  vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
  vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "q", api.tree.close, opts("Close"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

nvim_tree.setup(
  {
    on_attach = on_attach,
    hijack_cursor = true,
    view = {
      width = 50,
      side = "left"
    },
    renderer = {
      special_files = {"package.json", "Makefile", "README.md", "readme.md"},
      highlight_git = true,
      icons = {
        show = {
          git = true,
          folder = true,
          file = false,
          folder_arrow = true
        },
        glyphs = {
          git = {
            unstaged = "-"
          }
        }
      }
    },
    diagnostics = {
      enable = true,
      show_on_dirs = false,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR
      },
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = ""
      }
    }
  }
)
