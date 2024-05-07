function! customll#LightLineFilename()
  return expand('%')
endfunction

function! customll#LightLineAle()
  return ALEGetStatusLine()
endfunction

function! customll#ProjectBadge()
  let l:project = badge#project()
  let l:branch = badge#branch()

  return l:project . " ᚶ " . l:branch
endfunction
