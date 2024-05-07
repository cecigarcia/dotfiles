require "trouble".setup {
  icons = false,
  fold_open = "v",
  fold_closed = ">",
  action_keys = {
    toggle_mode = "m" -- toggle between "workspace" and "document" diagnostics mode
  },
  use_diagnostic_signs = true
}
