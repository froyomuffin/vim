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
" Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
" Plug 'nvim-tree/nvim-web-devicons'
Plug 'EdenEast/nightfox.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'chrisbra/colorizer'
Plug 'djoshea/vim-autoread'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'matze/vim-move'
Plug 'nanozuki/tabby.nvim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ojroques/nvim-lspfuzzy'
Plug 'rmagatti/goto-preview'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
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
map ' <leader>

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

" Bind reloading vimrc
nmap <leader>e :e $MYVIMRC<CR>
nmap <leader>l :so $MYVIMRC<CR>

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

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Ruby
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.mrb set syntax=ruby

" Python
autocmd FileType python setlocal shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.mrb set syntax=python

" Completion
imap <Tab> <C-x><C-]>
imap <Tab><Tab> <C-x><C-p>

" =========== Searching ===========
" Set up search history directory
let s:search_dir = "~/.vim/search"

if empty(glob(s:search_dir))
  call system('mkdir -p '.s:search_dir)
endif

function! s:find_project_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

" Search Helpers
function! s:filter_key_for(scope)
  let md5bin = executable('md5sum') ? 'md5sum' : 'md5'
  let md5_command = "echo '".s:find_project_root().a:scope."' | xargs | ".md5bin." | awk '{ printf $1 }'"
  return system(md5_command)
endfunction

function! s:filter_history_file_for(key)
  let filter_history_dir = s:search_dir.'/'
  let filter_history_file =  expand(filter_history_dir).a:key

  return filter_history_file
endfunction

function! s:last_filter_from(filter_history_file)
  let last_filter_command = "tail -n1 ".a:filter_history_file." |  tr -d '\n'"
  return system(last_filter_command)
endfunction

function! s:build_prepopulated_filters(default_filters, use_filters_from_history, filter_history_file)
  let prepopulated_filters = a:default_filters

  if (a:use_filters_from_history && filereadable(a:filter_history_file))
    let prepopulated_filters = prepopulated_filters.' '.s:last_filter_from(a:filter_history_file)
  endif

  let dedupe_command = "echo '".prepopulated_filters."' | tr ' ' '\n' | sort | uniq | xargs | tr -d '\n'"
  let prepopulated_filters = system(dedupe_command)

  if (len(prepopulated_filters) == 0)
    return prepopulated_filters
  else
    return prepopulated_filters.' '
  endif
endfunction

" Default filters
function! s:get_default_filters()
  return @f
endfunction

function! s:echo_default_filters()
  echom 'Default FZF Filters: '.@f
endfunction

function! s:set_default_filters(filters)
  let @f = a:filters
endfunction

command! -bang -nargs=? DefaultFilters
      \ call s:echo_default_filters()

command! -bang -nargs=* SetDefaultFilters
      \ call s:set_default_filters(<q-args>)

" History toggle
function! s:get_filter_history_enabled()
  return @g
endfunction

function! s:filter_history_enabled()
  if (@g)
    echom "History Filter Enabled"
  else
    echom "History Filter Disabled"
  endif
endfunction

function! s:toggle_filter_history()
  if (len(@g) == 0)
    let @g = 0
  else
    let @g = !@g
  endif

  call s:filter_history_enabled()
endfunction

command! -bang -nargs=? FilterHistoryEnabled
      \ call s:filter_history_enabled()

command! -bang -nargs=? ToggleFilterHistory
      \ call s:toggle_filter_history()

" FileSearch
function! s:file_search(default_filters, use_filters_from_history)
  let project_root = s:find_project_root()
  let filter_key = s:filter_key_for('file_search')
  let filter_history_file = s:filter_history_file_for(filter_key)
  let prepopulated_filters = s:build_prepopulated_filters(
        \  a:default_filters,
        \  a:use_filters_from_history,
        \  filter_history_file
        \)

  let base = fnamemodify(expand('%'), ':h:.:S')
  let file_search_command = base == '.' ? 'fd -t f' : 'fd -t f | proximity-sort '.expand('%')

  " \ call fzf#vim#files(
  " \   project_root,
  " \   {
  " \     'source': file_search_command,
  " \     'options':
  " \      ' --tiebreak=index'.
  " \      ' --history='.shellescape(filter_history_file).
  " \      ' --history-size=10'.
  " \      ' --query='.shellescape(prepopulated_filters)
  " \   },
  " \ )

  \ call fzf#vim#files(
  \   project_root,
  \   fzf#vim#with_preview({
  \     'source': file_search_command,
  \     'options':
  \        ' --tiebreak=index'.
  \        ' --history='.shellescape(filter_history_file).
  \        ' --history-size=10'.
  \        ' --query='.shellescape(prepopulated_filters)
  \   })
  \ )
endfunction

command! -bang -nargs=? FileSearch
      \ call s:file_search(s:get_default_filters(), s:get_filter_history_enabled())

" Search
function! s:search(query, default_filters, use_filters_from_history)
  let project_root = s:find_project_root()
  let filter_key = s:filter_key_for(a:query)
  let filter_history_file = s:filter_history_file_for(filter_key)
  let prepopulated_filters = s:build_prepopulated_filters(
        \  a:default_filters,
        \  a:use_filters_from_history,
        \  filter_history_file
        \)
  let search_command = 'rg --column --no-heading --line-number --color=always '.shellescape('(?s)'.a:query)

  \ call fzf#vim#grep(
  \   search_command,
  \   1,
  \   fzf#vim#with_preview({
  \     'dir': project_root,
  \     'options':
  \      ' --history='.shellescape(filter_history_file).
  \      ' --history-size=10'.
  \      ' --query='.shellescape(prepopulated_filters)
  \   })
  \ )
endfunction

command! -bang -nargs=* Search
      \ call s:search(<q-args>, s:get_default_filters(), s:get_filter_history_enabled())

" Bind DefaultFilters
map <leader>] :DefaultFilters<CR>

" Bind SetDefaultFilters
map <leader>]] :SetDefaultFilters 

" Bind ToggleFilterHistory
map <leader>[ :ToggleFilterHistory<CR>

" Bind FileSearch
map <C-p> :FileSearch<CR>
map <leader>p :FileSearch<CR>

" Bind Search
map <C-/> :Search 
map <leader>/ :Search 

" Bind Search under cursor
map <C-/><C-/> :Search <C-r><C-w><CR> 
map <leader>// :Search <C-r><C-w><CR>

" =================================

" Quick repeat
map <leader><leader><leader> @:

" Vim highlights
highlight SpellBad ctermfg=0
highlight Search ctermfg=0

" Buffer management
map <leader>b :Buffers<CR>

" Commenting
map <leader>c :Commentary<CR>

" Open git line in browser :)
map <leader>g :,GBrowse<CR>

" Colorizing hexcodes for
let g:colorizer_auto_filetype='css,html,conf'

" Unhighlight
map <leader>n :noh<CR>

lua << EOF

-- Set Theme
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = true,     -- Disable setting background
    terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,    -- Non focused panes set to alternative background
    module_default = true,   -- Default enable value for modules
    colorblind = {
      enable = true,        -- Enable colorblind support
      simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
      severity = {
        protan = 0,          -- Severity [0,1] for protan (red)
        deutan = 0,          -- Severity [0,1] for deutan (green)
        tritan = 0,          -- Severity [0,1] for tritan (blue)
      },
    },
    styles = {               -- Style to be applied to different syntax groups
      comments = "NONE",     -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})

-- Split matching combo
vim.keymap.set("n", "<C-v>", "<C-w>L<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-b>", "<C-w>J<CR>", { noremap = true, silent = true })

-- Language servers
require'lspconfig'.pyright.setup{}

require'lspconfig'.rubocop.setup{}
require'lspconfig'.ruby_lsp.setup{}
require'lspconfig'.sorbet.setup{
  cmd = { "srb", "tc", "--lsp", "--disable-watchman" }
}
vim.api.nvim_command("au BufRead,BufNewFile *.rbi setfiletype ruby")

-- Highlighting
require'nvim-treesitter.configs'.setup{
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "yaml", "ruby", "json", "liquid", "typescript"},
  highlight = {
    enable = true
  }
}

--vim.keymap.set("n", "gr", vim.lsp.buf.incoming_calls, { noremap = true, silent = true })
vim.keymap.set("n", "gi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "GI", vim.lsp.buf.implementation, { noremap = true, silent = true })

vim.keymap.set("n", "gd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "GD", vim.lsp.buf.definition, { noremap = true, silent = true })

vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true })

-- Preview Popup
require('goto-preview').setup {
  width = 120,
  height = 20,
}

-- LSP and fzf
require('lspfuzzy').setup {}

-- Terminal
vim.api.nvim_set_keymap("n", "<leader>x", ":ToggleTerm<CR>", { noremap = true })

require("toggleterm").setup {
  open_mapping = [[<c-x>]],
}

-- Tabs
vim.o.showtabline = 2

vim.api.nvim_set_keymap("n", "<C-t>", ":$tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":Tabby rename_tab ", { noremap = true })

local theme = {
  fill = 'TabLineFill',
  -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
  head = 'TabLine',
  current_tab = 'TabLineSel',
  tab = 'TabLine',
  win = 'TabLine',
tail = 'TabLine',
}
require('tabby').setup({
  line = function(line)
    return {
      {
        line.sep(' ', theme.head, theme.fill),
      },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab
        return {
          line.sep(' ', hl, theme.fill),
          tab.number(),
          tab.name(),
          line.sep(' ', hl, theme.fill),
          hl = hl,
          margin = ' ',
        }
      end),
      line.spacer(),
      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
        return {
          line.sep(' ', theme.win, theme.fill),
          win.is_current() and '' or '',
          win.buf_name(),
          line.sep(' ', theme.win, theme.fill),
          hl = theme.win,
          margin = ' ',
        }
      end),
      hl = theme.fill,
    }
  end,
  -- option = {}, -- setup modules' option,
})

EOF

colorscheme nightfox
