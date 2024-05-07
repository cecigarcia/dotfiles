vim.cmd [[
  command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

  aug b_morestuff
    au!

    au VimEnter * WipeReg

    au FocusGained,BufEnter * :checktime

    au FileType gitcommit setlocal textwidth=80

    au BufNew,BufRead *.fish set filetype=fish
    au BufNew,BufRead *.mdx set filetype=markdown

    au BufRead */nvim/*/doc/* :wincmd L
    au BufRead */nvim/*/doc/* :nmap <buffer> q :q<cr>
  aug end
]]


map("Q", [[:luado (function() end)()<cr>]], S)

map("j", [[gj]])
map("<down>", [[gj]])
map("k", [[gk]])
map("<up>", [[gk]])

map("<leader>a", 'ggVG')
map("gp", '`[v`]')

map("<tab>", [[:wincmd w<cr>]], S)
map("<s-tab>", [[:wincmd W<cr>]], S)


map("<backspace>", [[:nohlsearch<cr>:cclose<cr>:TroubleClose<cr>]], S)

map("<leader>ev", [[:e ~/.config/nvim/lua/config.lua<cr>]], S)
