function! s:ScanFile()
  let nmax = line('$')
  let n = 0
  while n < 20
    if getline(nmax - n) =~# "slide-pack.js"
      return 1
      break
    endif
    let n = n + 1
  endwhile
  return 0
endfunction

function! s:DetectSlidePack(file)
  if a:file =~# "\\v\\.html"
    if s:ScanFile()
      set ft=slidepack
    endif
  endif
endfunction

augroup SlidePackDetect
  autocmd!

  autocmd BufNewFile,BufRead,BufWritePost *.html call s:DetectSlidePack(expand("<afile>"))
augroup END
