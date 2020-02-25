" Load vim-plug
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
    call system('curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endif

" Set backupdir
if empty(glob("~/.vim/backup"))
    call system('mkdir -p ~/.vim/backup')
endif
set backupdir=~/.vim/backup//

call plug#begin('~/.local/share/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'chrisbra/colorizer'
Plug 'dag/vim-fish'
Plug 'djoshea/vim-autoread'
Plug 'elixir-editors/vim-elixir'
Plug 'rorymckinley/vim-rubyhash'
Plug 'flazz/vim-colorschemes'
Plug 'gcmt/taboo.vim'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'keith/swift.vim'
Plug 'leafgarland/typescript-vim'
Plug 'matze/vim-move'
Plug 'mklabs/split-term.vim'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neomake/neomake' 
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'scrooloose/syntastic'
Plug 'slashmili/alchemist.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'vim-ruby/vim-ruby'
Plug 'xolox/vim-misc'
call plug#end()

" Vim General
filetype plugin indent on
hi CursorLine cterm=NONE ctermbg=black
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
map <C-c><C-c> :q<CR>
set backspace=2
"set autochdir
set cursorline
set directory=~/.vim/wap//
set expandtab
set fillchars+=vert:\ 
set hidden
set hlsearch
set ignorecase
set incsearch
set modifiable
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

" Ruby convert rocket hashes to 1.9
command! ConvertHashes %s/:\(\w\+\)\s*=>\s*/\1: /g

" Python
autocmd FileType python setlocal shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.mrb set syntax=python

" Completion
imap <Tab> <C-x><C-]>
imap <Tab><Tab> <C-x><C-p>

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" =========== Searching ===========

" Project Root
function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

" RG from Project Root
command! -bang -nargs=* RRg
  \ call fzf#vim#grep('rg --column --no-heading --line-number --color=always '.shellescape(<q-args>),               
  \ 1,                                                                                                              
  \ fzf#vim#with_preview({'dir': s:find_git_root()}),                                             
  \ <bang>0)

" Search using RRG
map <C-_> :RRg 
" Find all occurences via FZF Rg
map <C-_><C-_> :RRg <C-r><C-w><CR>!test

" Files from Project Root sorted by proximity
function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd -t f' : printf('fd -t f | proximity-sort %s', expand('%'))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

command! ProjectFiles execute 'Files' s:find_git_root()
nnoremap <C-p> :ProjectFiles<CR>

" =================================

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

" Commenting
map <leader>c :Commentary<CR>

" Open git line in browser :)
map <leader>g :,Gbrowse<CR>

" Colorizing hexcodes for
let g:colorizer_auto_filetype='css,html,conf'

" Unhighlight
map <leader>n :noh<CR>
