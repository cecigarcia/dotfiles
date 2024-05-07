if exists("b:current_syntax")
  finish
endif

syntax match slide "\v^--.*$"
highlight link slide FoldColumn

syntax match slideSection "\v^--.*section.*$"
highlight slideSection guibg=#2aa198 guifg=#ffffff gui=bold cterm=bold

syntax match slideTodo "\vTODO"
highlight link slideTodo Todo

syntax region code start="\v^```.*$" skip=/\v\\./ end="\v^```.*$"
highlight link code Function

" syntax match slide "\v`.*`$"
" highlight link slide Keyword

let b:current_syntax = "slidepack"
