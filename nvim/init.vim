 if &shell =~# 'fish$'
    set shell=bash
 endif

 set nocompatible              " be iMproved, required
 filetype off                  " required

 " set the runtime path to include Vundle and initialize
 set rtp+=~/.config/nvim/bundle/Vundle.vim
 call vundle#begin()
 " alternatively, pass a path where Vundle should install plugins
 "call vundle#begin('~/some/path/here')

 " let Vundle manage Vundle, required
 Plugin 'VundleVim/Vundle.vim'

 " -- Leader key -----
 let mapleader="ñ"

 " -- Vimhaviour -----

 " ~ Spaces and tabs ~
 set tabstop=2
 set softtabstop=2
 set shiftwidth=2
 set expandtab
 set shiftround
 set autoindent
 set smartindent

 " ~ Backspace ~
 set backspace=start,eol,indent

 " ~ Buffers ~
 set hidden
 set switchbuf=usetab
 set splitright
 set splitbelow
 set equalalways

 " ~ Backups ~
 set noswapfile
 set nobackup
 set nowritebackup

 " ~ Search ~
 set hlsearch
 set incsearch
 set ignorecase
 set smartcase
 set rtp+=~/.fzf

 " ~ Cursor ~
 let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1


 " ~ Use system clipboard as default buffer
 " ~ Allows yanking between vim/gvim instances
 set clipboard=unnamed

 " ~ Diff ~
 set diffopt+=iwhite

 " ~ Ruby slowness hack ~:w
 let g:ruby_path = system('echo $HOME/.rbenv/shims')

 " ~ Languages ~
 Plugin 'vim-ruby/vim-ruby'
 Plugin 'vim-coffee-script'
 Plugin 'Markdown'
 Plugin 'tpope/vim-rails'
 Plugin 'elixir-lang/vim-elixir'
 Plugin 'elmcast/elm-vim'


 " ~ Utils ~
 Plugin 'The-NERD-tree'
 Plugin 'jistr/vim-nerdtree-tabs'
 Plugin 'Xuyuanp/nerdtree-git-plugin'
 Plugin 'mattn/emmet-vim'
 Plugin 'scrooloose/nerdcommenter'
 Plugin 'Lokaltog/vim-powerline'
 Plugin 'bling/vim-airline'
 Plugin 'ctrlp.vim'
 Plugin 'ZoomWin'
 Plugin 'surround.vim'
 Plugin 'repeat.vim'
 Plugin 'tpope/vim-unimpaired'
 Plugin 'tomtom/quickfixsigns_vim'
 Plugin 'tpope/vim-fugitive'
 Plugin 'ervandew/supertab'
 Plugin 'rking/ag.vim'
 Plugin 'Syntastic'
 Plugin 'kana/vim-textobj-user'
 Plugin 'kana/vim-textobj-line'
 Plugin 'tpope/vim-eunuch'
 Plugin 'tpope/vim-abolish'
 Plugin 'nelstrom/vim-qargs'
 Plugin 'godlygeek/tabular'
 Plugin 'tpope/vim-jdaddy'
 Plugin 'dag/vim-fish'

 " ~ Themes ~
 "Plugin 'badwolf'
 Plugin 'morhetz/gruvbox'
 Plugin 'mhartington/oceanic-next'


 Plugin 'sjl/vitality.vim'
 Plugin 'jceb/vim-orgmode'
 Plugin 'tpope/vim-speeddating'

 " ~ Highlighting ~
 Plugin 'sheerun/vim-polyglot'
 let g:jsx_ext_required = 0
 let g:javascript_plugin_jsdoc = 1
 let g:javascript_plugin_flow = 1
 Plugin 'othree/yajs.vim'
 Plugin 'isRuslan/vim-es6'


 call vundle#end()            " required
 filetype plugin indent on    " required

 syntax enable

 " -- GUI customization ----
 set guioptions=

 "set guifont=Inconsolata\ for\ Powerline:h15

 set guifont=Menlo\ for\ Powerline:h14


 set cul
 set number
 set showmatch

 set laststatus=2
 set showtabline=2
 set scrolloff=3

 set wildmenu
 set wildmode=list:longest

 set wrap
 set whichwrap=b,s,l,h,<,>,~,[,]

 set list
 set listchars -=eol:$
 set listchars +=trail:·
 set listchars +=tab:▸.

 set mouse=a

 set lazyredraw

 set t_Co=256
 set background=dark

 "colorscheme badwolf
 "colorscheme gruvbox
  " Theme
  syntax enable
  " for vim 7
  set t_Co=256

  " for vim 8
  if (has("termguicolors"))
  set termguicolors
  endif

  colorscheme OceanicNext

 syntax enable

 highlight NonText guifg=#333333
 highlight SpecialKey guibg=#555555 guifg=white
 highlight CursorLine guibg=#111111

 " -- Plugin customizations ----
 " ~ Vim-Ruby ~
 imap <s-cr> <cr><cr>end<esc>-cc

 " ~ The NERD tree ~
 let NERDTreeChDirMode=2
 let NERDTreeMouseMode=3
 nnoremap <silent> <leader>p :NERDTreeTabsToggle<cr>

 " ~ Powerline ~
 let g:airline_powerline_fonts = 1
 let g:Powerline_symbols='fancy'

 if !exists('g:airline_symbols')
   let g:airline_symbols = {}
 endif

 if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
 endif

 "Setting here the symbols was the only way I found to
 " show the glyphs in the statusline (got at
 " https://github.com/bling/vim-airline/issues/76?source=cc)
 let g:airline_left_sep         = '⮀'
 let g:airline_left_alt_sep     = '⮁'
 let g:airline_right_sep        = '⮂'
 let g:airline_right_alt_sep    = '⮃'
 let g:airline_symbols.branch   = '⭠'
 let g:airline_symbols.readonly = '⭤'
 let g:airline_symbols.liner    = '⭡'

 "Enabling jsx highlight plugin to works with .js
 let g:jsx_ext_required = 0

 " ~ ctrlp.vim ~
 set wildignore +=*.git
 set wildignore +=*.svn
 set wildignore +=*.class
 set wildignore +=target/**
 set wildignore +=.bundle
 set wildignore +=node_modules/**
 set wildignore +=tmp/**
 let g:ctrlp_custom_ignore = { 'dir': 'tmp\|.sass-cache\|file_repository\|node_modules', 'file': '\.DS_Store' }

 let g:ctrlp_max_height=15
 let g:ctrlp_jump_to_buffer=2
 let g:ctrlp_map = '<leader>f'
 let g:ctrlp_working_path_mode=2

 nmap <silent> <leader>b :CtrlPBuffer<cr>

 " ~ ZoomWin ~
 map <silent> <leader><leader> :ZoomWin<cr>

 " ~ Vim-unimpaired ~
 " Bubble single lines
 nmap <c-up> [e
 nmap <c-down> ]e
 " Bubble multiple lines
 vmap <c-up> [egv
 vmap <c-down> ]egv

 " ~ Fugitive vim ~
 nnoremap <leader>gs :Gstatus<cr>
 nnoremap <leader>gd :Gdiff<cr>
 nnoremap <leader>gc :Gcommit<cr>

 " ~ Syntastic ~
 let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['scss', 'sass'] }
 let g:syntastic_javascript_checkers = ['eslint']

" -- General Mappings ----

 " ~ Remove searchhighlight ~
 nnoremap <silent> <backspace> :nohlsearch<cr>

 " ~ Easy editting and resourcing of .*vimrc files ~
 nnoremap <leader>ev :tabedit ~/.vimrc<cr>
 nnoremap <leader>sv :source ~/.vimrc<cr>
 nnoremap <leader>egv :tabedit ~/.gvimrc<cr>
 nnoremap <leader>sgv :source ~/.gvimrc<cr>

 " ~ Move between windows ~
 imap <silent> <a-Left> <esc>:wincmd h<cr>
 nmap <silent> <a-Left> :wincmd h<cr>
 nmap <silent> <a-h> :wincmd h<cr>

 imap <silent> <a-Right> <esc>:wincmd l<cr>
 nmap <silent> <a-Right> :wincmd l<cr>
 nmap <silent> <a-l> :wincmd l<cr>

 imap <silent> <a-Up> <esc>:wincmd k<cr>
 nmap <silent> <a-Up> :wincmd k<cr>
 nmap <silent> <a-k> :wincmd k<cr>

 imap <silent> <a-Down> <esc>:wincmd h<cr>
 nmap <silent> <a-Down> :wincmd j<cr>
 nmap <silent> <a-j> :wincmd j<cr>

 "~ Cycle through windows ~
 nnoremap <silent> <tab> :wincmd w<cr>
 nnoremap <silent> <s-tab> :wincmd W<cr>

 " ~ Move between tabs ~
 map <silent> <c-tab> :tabnext<cr>
 imap <silent> <c-tab> <esc>:tabnext<cr>
 map <silent> <c-s-tab> :tabprevious<cr>
 imap <silent> <c-s-tab> <esc>:tabprevious<cr>

 " ~ Goto EOL in insert mode ~
 inoremap <c-e> <esc>A

 " ~ New line ~
 imap <silent> <c-return> <esc>o

 " ~ Selections ~
 " all doc
 nnoremap <leader>a ggVG
 " last edited
 nmap gV `[v`]

 " ~ Fix movements in wrapped lines ~
 noremap j gj
 noremap <down> gj
 noremap k gk
 noremap <up> gk

 " ~ Bubbling ~
 nmap <C-Up> ddkP
 nmap <C-Down> ddp
 vmap <C-Up> xkP`[V`]
 vmap <C-Down> xp`[V`]

 " ~ Fast macro (recorded with qq) ~
 nnoremap <space> @q
 nnoremap <space><space> @@

 " -- Autocommands ----

 " ~ Fix filetypes ~
 autocmd BufRead *.coffe* :set ft=coffee
 autocmd BufRead *.eco* :set ft=eco

 " ~ Help window to the right ~
 augroup Help2Right
  "autocmd!
  "autocmd BufRead $HOME/.vim/*/doc/* :wincmd L
  "autocmd BufRead */vim/*/doc/* :wincmd L
  "autocmd BufRead */snippets/* highlight SpecialKey guibg=#00bb00 guifg=white
 augroup end

 " ~ Close help with q ~
 augroup HelpClose
  "autocmd!
  "autocmd! BufRead */vim/*/doc/* :nmap <buffer> q :q<cr>
  "autocmd! BufRead $HOME/.vim/*/doc/* :nmap <buffer> q :q<cr>
 augroup end

 " Managing Vim config
 nnoremap <leader>ev :e $MYVIMRC<CR>
 nnoremap <leader>sv :source $MYVIMRC<CR>
