" Load vim-plug
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
    execute 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'vim-ruby/vim-ruby'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'dag/vim-fish'
" Plug 'ervandew/supertab'
call plug#end()

" Tagbar
map <C-x> :TagbarToggle<CR>

" FZF
map <C-p> :FZF<CR>
map <C-p><C-p> :FZF 

" More natural navigation in Vim
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

" vim-airline
set t_Co=256
set laststatus=2
" Disable the '>' so that we don't need patched fonts everywhere
let g:airline_left_sep=''
let g:airline_right_sep=''

" CPP
let g:cpp_class_scope_highlight=1
map <C-n><C-n> :e %<.cpp<CR>
map <C-n> :e %<.h<CR>

" Ruby
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2

" Supertab
" let g:SuperTabDefaultCompletionType = "context"
" let g:SuperTabDefaultCompletionType = "<c-x><c-]>"

" FZF
" Match theme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Splits
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

" Vim
syntax on
set fillchars+=vert:\ 
set number
set relativenumber
set incsearch
set scrolloff=4
set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set ignorecase
set smartcase
set backspace=2
filetype plugin indent on
set timeoutlen=400

" Completion
imap <Tab> <C-x><C-]>
imap <Tab><Tab> <C-x><C-p>

" Searching
" Find all occurences via FZF Ag
map <C-_> :Ag <C-r><C-w><CR>!tags 

" Force bash here to speed up loading (issue with fish)
set shell=/bin/bash

" Vim highlights
highlight SpellBad ctermfg=0
highlight Search ctermfg=0

" Ctags
" Find tags recursively upwards until home
set tags+=tags;~

" Easytags
" Use vim's tag
let g:easytags_dynamic_files = 1
" Use python
let g:easytags_python_enabled = 1
" Ignore the global tag file by sending to /dev/null
:let g:easytags_file = '/dev/null'
