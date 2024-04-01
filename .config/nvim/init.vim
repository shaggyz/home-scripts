" -----------------------------------------------------------------------------
" Nico's neovim configuration for Linux and macOS
" -----------------------------------------------------------------------------
" The following configuration files are part of this file too:
"
" ~/.config/nvim/lua/config.lua - configuration available in lua.
" ~/.config/nvim/ginit.lua - specific configuration for neovim-qt.


" -----------------------------------------------------------------------------
" ❇ Plugins: installation, using: https://github.com/junegunn/vim-plug#neovim
" -----------------------------------------------------------------------------

call plug#begin()
" Rose-pine colorscheme
Plug 'rose-pine/neovim'
" CoC for neovim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Fuzz search
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
" Icons
Plug 'ryanoasis/vim-devicons'
" Markdown plugin
Plug 'preservim/vim-markdown'
" Emmet, HTML tools
Plug 'mattn/emmet-vim'
" Airline bar
Plug 'vim-airline/vim-airline'
" Themes collection for airline
Plug 'vim-airline/vim-airline-themes'
" Close all the buffers
Plug 'schickling/vim-bufonly'
" Floating terminal
Plug 'numToStr/FTerm.nvim'
" Git signs in buffers
Plug 'lewis6991/gitsigns.nvim'
" Automatically remove whitespaces
Plug 'ntpeters/vim-better-whitespace'
" Max width column
Plug 'xiyaowong/virtcolumn.nvim'
" Icons used by FZF
Plug 'nvim-tree/nvim-web-devicons'
" File tree
Plug 'nvim-tree/nvim-tree.lua'
" Git CLI complement
Plug 'tpope/vim-fugitive'
" Adds additional highlight groups, used for syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Color Scheme edition plugins:
" Colorcheme creation
" Plug 'rktjmp/lush.nvim'
" Playground for treesitter
" Plug 'nvim-treesitter/playground'

" Debugger testing
" Plug 'mfussenegger/nvim-dap'
" Plug 'mfussenegger/nvim-dap-python/'
call plug#end()

" -----------------------------------------------------------------------------
" ❇ Neovim: editor settings
" -----------------------------------------------------------------------------

set tabstop=4
set shiftwidth=4
set softtabstop=4

set cursorline
set number
set conceallevel=2
set cc=100
set termguicolors
set signcolumn=yes

set noswapfile
set autoindent
set mouse=a
set wildmenu
set expandtab
set nofoldenable
set updatetime=300

filetype plugin indent on
syntax on

colorscheme rose-pine-main

" ~/.config/nvim/lua/config.lua
lua require('config')


" -----------------------------------------------------------------------------
" ❇ Plugins: configuration
" -----------------------------------------------------------------------------

" Vim Airline -----------------------------------------------------------------
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#error_symbol = ' '
let g:airline#extensions#coc#warning_symbol = ' '
let g:airline#extensions#coc#show_coc_status = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_c_only_filename = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#hunk_symbols = [' ', ' ', ' ']

" Override powerline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.dirty=''
let g:airline_symbols.linenr = ' Ⓛ '
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.colnr = 'Ⓒ '
let g:airline_symbols.branch = ' '

" Patch the airline theme
"function! s:update_highlights()
"    hi CursorLine ctermbg=none guibg=NONE
"    hi VertSplit ctermbg=none guibg=NONE
"endfunction
"autocmd User AirlineAfterTheme call s:update_highlights()

" Emmet -----------------------------------------------------------------------
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue,php EmmetInstall

" CoC -------------------------------------------------------------------------
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" PyRight: :CocInstall coc-pyright --------------------------------------------
" Add mypy:python.linting.mypyEnabled
" TBD.

" Better Whitespace -----------------------------------------------------------
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0


" -----------------------------------------------------------------------------
" ❇ Keybindings:
" -----------------------------------------------------------------------------

let mapleader=','

" CTRL+h: move to the previous buffer
nmap <C-h> :bprev!<CR>
" CTRL+l: move to the next buffer
nmap <C-l> :bnext!<CR>
" ,q: close the current buffer w/o closing the window and move to the previous
nnoremap <Leader>q :bp<CR> :bd#<CR>
" CTRL+c CTRL+c: Remove hlsearch
nnoremap <C-c><C-c> :silent! nohls<CR>
" ,ca: Close all the buffers, except the current one
nmap <leader>ca :BufOnly<CR>

" Use K to show documentation in preview window
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <silent> K :call ShowDocumentation()<CR>

" CTRL+i: toggle the terminal
nnoremap <C-i> <cmd>lua require("FTerm").toggle()<CR>
tnoremap <C-i> <C-n><CMD>lua require("FTerm").toggle()<CR>

" ,ev: edit CLI configuration
nnoremap <leader>ev :e $MYVIMRC<CR>
" ,gv: edit GUI configuration
nnoremap <leader>gv :e $HOME/.config/nvim/ginit.vim<CR>
" ,lv: edit LUA configuration
nnoremap <leader>lv :e $HOME/.config/nvim/lua/config.lua<CR>

" Coc:
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>yy <Plug>(coc-type-definition)
nmap <silent> <leader>im <Plug>(coc-implementation)
nmap <silent> <leader>us <Plug>(coc-references)

" Symbol Rename:
nmap <leader>rn <Plug>(coc-rename)

" Formatting Code:
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use <tab> for autotomplete options
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" FZF:
nnoremap <leader>f <cmd>lua require('fzf-lua').files()<CR>
nnoremap <leader>o <cmd>lua require('fzf-lua').buffers()<CR>
nnoremap <leader>g <cmd>lua require('fzf-lua').live_grep({ cmd = "git grep --line-number --column --color=always" })<CR>

" NvimTree:
nnoremap <leader>v <cmd>NvimTreeToggle<CR>
nnoremap <leader>r <cmd>NvimTreeFindFile<CR>

" Terminal Keybindings:
tunmap <Tab>
