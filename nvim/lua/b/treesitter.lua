require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "comment",
    "css",
    "dockerfile",
    "fish",
    "graphql",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "latex",
    "lua",
    "regex",
    "ruby",
    "toml",
    "typescript",
    "tsx",
    "yaml"
  },

  highlight = {
    enable = true,
  },

  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
