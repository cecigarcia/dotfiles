local util = require "lspconfig/util"

local M = {}

local buf_map = vim.api.nvim_buf_set_keymap

function M.on_attach(_, bufnr)
  vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false
    }
  )

  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspDeclaration lua vim.lsp.buf.declaration()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspOrganize lua lsp_organize_imports()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

  buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
  buf_map(bufnr, "n", "gr", ":LspRename<CR>", {silent = true})
  buf_map(bufnr, "n", "gR", ":LspRefs<CR>", {silent = true})
  buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
  buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
  buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
  buf_map(bufnr, "i", "<C-space>", "<cmd> LspSignatureHelp<CR>", {silent = true})

  vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")

  vim.cmd("sign define LspDiagnosticsSignError text=✖")
  vim.cmd("sign define LspDiagnosticsSignWarning text=⚠")
  vim.cmd("sign define LspDiagnosticsSignInformation text=ℹ")
  vim.cmd("sign define LspDiagnosticsSignHint text=➤")

  -- Lsp signature
  -- require("lsp_signature").on_attach()

  -- LspSaga goodies
  -- buf_map(bufnr, "n", "<Leader>d", ":Lspaga show_line_diagnostics<CR>", {silent = true})
  buf_map(bufnr, "n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", {silent = true})
  buf_map(bufnr, "n", "]d", ":Lssaga diagnostic_jump_next<CR>", {silent = true})
  buf_map(bufnr, "n", "<S-up>", ":Lspsaga diagnostic_jump_prev<CR>", {silent = true})
  buf_map(bufnr, "n", "<S-down>", ":Lspsaga diagnostic_jump_next<CR>", {silent = true})
  buf_map(bufnr, "n", "K", ":Lspsaga hover_doc<CR>", {silent = true})

  -- if client.resolved_capabilities.document_highlight then
  --     vim.api.nvim_exec([[
  --     hi LspReferenceRead cterm=bold ctermbg=red guibg=LightGray guifg=Black
  --     hi LspReferenceText cterm=bold ctermbg=red guibg=LightGray guifg=Black
  --     hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightGray guifg=Black
  --     augroup lsp_document_highlight
  --         autocmd!
  --         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --     augroup END
  --     ]], true)
  -- end

  -- if client.resolved_capabilities.document_formatting then
  --     vim.api.nvim_exec([[
  --      augroup LspAutocommands
  --          autocmd! * <buffer>
  --          autocmd BufWritePost <buffer> LspFormatting
  --      augroup END
  --      ]], true)
  -- end
end

M.root = util.root_pattern

return M
