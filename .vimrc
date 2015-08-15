set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'valloric/youcompleteme'
Plugin 'taglist.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'FelikZ/ctrlp-py-matcher'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" NERD Tree
autocmd BufEnter * lcd %:p:h
map <C-x><C-x> :NERDTreeFind<CR>
let g:NERDTreeWinSize=30

" Taglist
let Tlist_Use_Right_Window=1
let Tlist_WinWidth=30

" NERD Tree & Taglist
map <C-x> :NERDTreeToggle <bar> TlistToggle<CR>

" CScope
map <C-\> :cs find 3 <cword><CR>
cs add cscope.out

" CTags
set tags=./tags,tags;$HOME

" YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" CTRL-P
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" CPP
let g:cpp_class_scope_highlight=1
map <C-n><C-n> :e %<.cpp<CR>
map <C-n> :e %<.h<CR>

" General VIM
syntax on
set number
set incsearch
set scrolloff=4
set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
filetype plugin indent on
