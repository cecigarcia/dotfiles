" Adapted from https://github.com/wincent/wincent/blob/master/roles/dotfiles/files/.vim/after/plugin/color.vim
function! themeutils#GetBase16Scheme()
  let s:scheme_config = expand("~/.vim/.base16")
  if filereadable(s:scheme_config)
    let s:scheme = readfile(s:scheme_config)

    if filereadable(expand('~/.vim/plugged/base16-vim/colors/base16-'. s:scheme[0] . '.vim'))
      return s:scheme[0]
    else
      echoerr 'Bad colorscheme '. s:scheme[0] . ' in ' . s:scheme_config
      return "default"
    endif
  endif
endfunction

function! themeutils#CheckColorScheme()
  let s:scheme = themeutils#GetBase16Scheme()
  execute 'color base16-' .s:scheme

  call themeutils#SearchHighlightUpdate()
  call themeutils#TweakTheme()
  call themeutils#TweakStatus()
endfunction

function! themeutils#SearchHighlightUpdate()
  highlight clear Search
  hi Search cterm=NONE ctermfg=black ctermbg=yellow guifg=#000000 guibg=#FAC863

  " if &background ==# "light"
  "   hi Search cterm=NONE ctermfg=white ctermbg=black guifg=#000000 guibg=#FAC863
  " else
  "   hi Search cterm=NONE ctermfg=white ctermbg=black guifg=#000000 guibg=#FAC863
  " endif
endfunction

function! themeutils#TweakTheme()
  let s:scheme = themeutils#GetBase16Scheme()

  if s:scheme =~# 'light'
    highlight ALEErrorSign guifg=#ff7733 guibg=#222222
    highlight ALEError guifg=#ff7733 cterm=underline
    " highlight ALEErrorLine guibg=#ffd7c3
    " highlight ALEWarningLine guibg=#fffec3
    highlight ALEWarning guibg=#fffec3
    highlight clear SpellBad
    highlight SpellBad guifg=#ff7733 cterm=underline
    highlight MatchParen guifg=#268bd2 guibg=#ffffff cterm=bold,underline
    highlight Visual term=reverse guibg=#d3d1d1
  else
    highlight ALEErrorSign guifg=#cc4b15 guibg=#222222
    highlight ALEError guifg=#c594c5 cterm=underline
    " highlight ALEErrorLine guibg=#294352
    " highlight ALEWarningLine guibg=#17252d
    highlight ALEWarning guibg=#17252d
    highlight clear SpellBad
    highlight SpellBad guifg=#c594c5 cterm=underline
    highlight MatchParen guifg=#5f8700 guibg=NONE cterm=bold,underline
    highlight Visual term=reverse guibg=#1e4457
  endif

endfunction

function! themeutils#TweakStatus()
  let s:scheme = themeutils#GetBase16Scheme()

  if s:scheme =~# 'light'
    call tb_statusline#SetTheme('solarized_light')
  elseif s:scheme =~# 'gruvbox'
    call tb_statusline#SetTheme('gruvbox_dark')
  else
    call tb_statusline#SetTheme('solarized_dark')
  endif
endfunction
