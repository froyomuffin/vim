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
Plug 'ervandew/supertab'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
call plug#end()

" Old plugins in need of review
"Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'valloric/youcompleteme'
"Plugin 'majutsushi/tagbar'
"Plugin 'rust-lang/rust.vim'
"Plugin 'FelikZ/ctrlp-py-matcher'
"Plugin 'gtags.vim'
"Plugin 'rking/ag.vim'
"Plugin 'bling/vim-airline'
"Plugin 'tpope/vim-fugitive'
"Plugin 'eagletmt/ghcmod-vim'
"Plugin 'eagletmt/neco-ghc'
"Plugin 'sdiehl/haskell-vim-proto'
"Plugin 'scrooloose/syntastic'

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

" Vim
syntax on
set fillchars+=vert:│
set number
set relativenumber
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

" Ctags
" Find tags recursively upwards until home
set tags+=tags;~
" Set easytags to use vim's tag
let g:easytags_dynamic_files = 1

" Vim highlights
highlight SpellBad ctermfg=0
highlight Search ctermfg=0
