set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'valloric/youcompleteme'
Plugin 'majutsushi/tagbar'
Plugin 'rust-lang/rust.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'gtags.vim'
Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'

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

" Tagbar
map <C-x> :TagbarToggle<CR>

" GTags
map <C-]> :Gtags<CR><CR>
map <C-]><C-]> :cclose<CR>
map <C-\> :Gtags -r<CR><CR>
map <C-\><C-\> :cclose<CR>

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
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40

" vim-airline
set t_Co=256
set laststatus=2
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1

" CPP
let g:cpp_class_scope_highlight=1
map <C-n><C-n> :e %<.cpp<CR>
map <C-n> :e %<.h<CR>

" Vim
syntax on
set number
set incsearch
set scrolloff=4
set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set smartcase
set backspace=2
filetype plugin indent on

" Vim highlights
highlight SpellBad ctermfg=0
highlight Search ctermfg=0

" More natural navigation in Vim
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk
