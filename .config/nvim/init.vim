" Load vim-plug
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
    execute 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'dag/vim-fish'
Plug 'djoshea/vim-autoread'
Plug 'elixir-editors/vim-elixir'
Plug 'gcmt/taboo.vim'
Plug 'flazz/vim-colorschemes'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'keith/swift.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mklabs/split-term.vim'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neomake/neomake' 
Plug 'scrooloose/syntastic'
Plug 'slashmili/alchemist.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'xolox/vim-misc'
call plug#end()

" Vim General
filetype plugin indent on
hi CursorLine cterm=NONE ctermbg=black
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
map <C-c><C-c> :q<CR>
set backspace=2
set backupdir=~/.vim/backup//
set cursorline
set directory=~/.vim/wap//
set expandtab
set fillchars+=vert:\ 
set hidden
set hlsearch
set ignorecase
set incsearch
set mouse=a
set noswapfile
set number
set relativenumber
set scrolloff=4
set shiftwidth=2
set smartcase
set softtabstop=2
set tabstop=2
set timeoutlen=400
syntax on

" More natural navigation in Vim
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

" Allow ; alone to speed up :
nnoremap ; :

" Leader setup
set showcmd
let mapleader = '\'

" Character limit bar
set colorcolumn=120
highlight ColorColumn ctermbg=black guibg=black
"highlight OverLength ctermfg=white guibg=black
"match OverLength /\%121v.*/

" GitGutter
map <C-s> :GitGutterToggle<CR>

" FZF
map <C-p> :FZF<CR>
map <C-p><C-p> :FZF 

" FZF - Match theme
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

" vim-airline
set t_Co=256
set laststatus=2
" vim-airline - Disable the '>' so that we don't need patched fonts everywhere
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_b = ''

" Tab naviation
map <leader>t<left> :tabp<cr>
map <leader>t<right> :tabn<cr>

" CPP
let g:cpp_class_scope_highlight=1
map <C-n><C-n> :e %<.cpp<CR>
map <C-n> :e %<.h<CR>

" Splits
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-t': 'tabedit',
      \ 'ctrl-x': 'bd'
      \ }
set splitbelow
set splitright
highlight VertSplit cterm=none gui=none 
set fillchars+=vert:│

" Autoload vimrc on change (not working)
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Bind reloading vimrc until autoloading works
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>

" airline
let g:airline_section_b = ''

" Neomake
let g:neomake_ruby_enabled_makers = ["rubocop", "mri"]
au BufWinEnter *.rb :let b:neomake_ruby_rubocop_exe =  system('PATH=$(pwd)/bin:$PATH && which rubocop | tr -d "\n"')
au BufWinEnter,BufWritePost * Neomake

highlight NeomakeErrorMsg ctermfg=227 ctermbg=237
let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeErrorMsg'}

" Persistent undo
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undo//
endif

" Fast up and down
map <S-Up> 5k
map <S-Down> 5j
map <C-K> 5k
map <C-J> 5j
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

" Clipboard
set clipboard=unnamedplus

" Ruby
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.mrb set syntax=ruby

" Completion
imap <Tab> <C-x><C-]>
imap <Tab><Tab> <C-x><C-p>

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Searching
map <C-_> :Rg 
" Find all occurences via FZF Rg
map <C-_><C-_> :Rg <C-r><C-w><CR>!tags 

" Force bash here to speed up loading (issue with fish)
set shell=/bin/bash

" Vim highlights
highlight SpellBad ctermfg=0
highlight Search ctermfg=0

" Buffer through FZF
map <C-b> :Buffers<CR> 

" Tab
map <C-t> :tabn<CR>
map <leader>t :TabooOpen 
map <leader>tt :TabooRename 
map <leader>tc :tabclose<CR>

" Terminal setup
map <leader>f :15Term fish<CR>
tnoremap <Esc> <C-\><C-n>
