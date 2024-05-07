require("nvim-treesitter.configs").setup(
  {
    ensure_installed = {
      "rust",
      "fish",
      "javascript",
      "typescript",
      "tsx",
      "toml",
      "fish",
      "json",
      "yaml",
      "html",
      "scss",
      "markdown",
      "markdown_inline",
      "lua",
      "vim",
      "vimdoc",
      "c"
    },
    indent = {
      enable = false
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 1000
    }
  }
)
