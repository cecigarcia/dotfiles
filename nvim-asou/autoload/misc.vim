function! misc#word_processor(...) abort
  setlocal formatoptions=1qnb
  setlocal spell
  setlocal spelllang="es"
  " let l:spelllang = a:0 > 0 ? a:1 : "es"
  setlocal complete+=s
  " setlocal formatprg=par
  setlocal textwidth=80
  setlocal wrap
  setlocal linebreak
  setlocal nolist
endfunction

" Move to .vimrc window or open it in tab
function! misc#OpenVimRC()
  let l:vimrc_window = bufwinnr(expand("~/.vimrc"))
  if (l:vimrc_window == -1)
    :tabedit ~/.vimrc
  else
    :exec l:vimrc_window . "wincmd w"
  endif
endfunction

fun! misc#commandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
