function _G.setupTextEdit(lang)
  lang = lang or "en"
  vim.bo.tw = 120
  vim.bo.wrapmargin = 2
  vim.bo.spelllang = lang
  vim.wo.spell = true
  return
end

function _G.disableTextEdit()
  vim.wo.spell = false
  return
end


vim.cmd [[
  command! -nargs=? TEdit :lua _G.setupTextEdit(<f-args>)
  command! TEditDisable :lua _G.disableTextEdit()
]]

