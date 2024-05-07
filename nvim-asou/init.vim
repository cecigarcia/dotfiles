" .vimrc my friend
" ================

if (has("termguicolors"))
  if exists('$TMUX')
    " tmux fu!
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
  end
  set termguicolors
endif

if has('linebreak')
  let &showbreak='⤷ '
endif

"Fix xterm keys in tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

function! LoadMainNodeModule(fname)
  let nodeModules = "./node_modules/"
  let packageJsonPath = nodeModules . a:fname . "/package.json"
  let fileSrcPath = "./src" . a:fname

  if filereadable(packageJsonPath)
    return nodeModules . a:fname . "/" . json_decode(join(readfile(packageJsonPath))).main
  else
    return nodeModules . a:fname
  endif
endfunction

set includeexpr=LoadMainNodeModule(v:fname)

" enable omnicompletion
set omnifunc=syntaxcomplete#Complete

" lua require('plenary.reload').reload_module('asou', true)
lua require('asou.init')

" Filetype
filetype plugin indent on

" TODO make this shiat work!!!
" hi TabLineFill ctermbg=234 ctermfg=108 guifg=#990000 guibg=#000000
" hi TabLine ctermbg=234 ctermfg=108
" hi TabLineSel ctermbg=234 ctermfg=108


" Autocommands {{{

" Only show cursorline in the current window and in normal mode.
augroup cline
    autocmd!
    autocmd WinLeave,InsertEnter * set nocursorline
    autocmd BufRead,WinEnter,InsertLeave * set cursorline
augroup END

" Resize windows on focus
augroup AutoResize
  autocmd!
  autocmd FocusGained * wincmd =
  autocmd VimResized * wincmd =
  autocmd VimEnter * wincmd =
augroup END

function! PopOutOfInsertMode()
  if v:insertmode
    feedkeys("\<C-\>\<C-n>")
  endif
endfunction

augroup stuff_aug
  autocmd!

  " Enter normal mode when focus is lost
  autocmd FocusLost * call PopOutOfInsertMode()
augroup END

" Close help with q
augroup HelpWindows
  autocmd!
  autocmd FileType help :nmap <buffer> q :q<cr>
  autocmd FileType help wincmd L
augroup end

augroup TasksFile
  autocmd!
  autocmd! BufRead */Dropbox/tasks/* setlocal spell spelllang=es
augroup end

augroup Markdown
  autocmd!
  autocmd BufRead,BufNewFile *.mdx,*.md set filetype=markdown
  autocmd BufRead,BufNewFile *.mdx,*.md call misc#word_processor()
augroup END

augroup FileTypesAug
  autocmd!

  autocmd FileType python setl omnifunc=pythoncomplete#Complete
  " autocmd FileType javascript,jsx,javascript.jsx setl omnifunc=LanguageClient#complete
  autocmd FileType javascript,jsx,javascript.jsx,javascriptreact setl omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType css,scss,sass,stylus,less setl omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType html,htmldjango,jinja,markdown setl omnifunc=emmet#completeTag
  autocmd FileType xml setl omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd Filetype gitcommit setlocal spell
  autocmd Filetype less,css,scss,js setlocal iskeyword+=-
  autocmd Filetype less,css,scss setlocal iskeyword-=:
  autocmd FileType text,markdown,mdx setlocal spell textwidth=80

  autocmd BufNewFile,BufRead *.yml setf eruby
  autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Capfile,Guardfile,config.ru,.railsrc,.irbrc,.pryrc} set ft=ruby
  autocmd BufRead,BufNewFile *.less set filetype=less
augroup END

autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

" Drew Neil's copy quickfix to args
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
