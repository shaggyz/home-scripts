" -----------------------------------------------------------------------------
" Nico's neovim configuration for Linux and macOS
" -----------------------------------------------------------------------------
" The following configuration files are part of this file too:
"
" ~/.config/nvim/lua/config.lua - configuration available in lua.
" ~/.config/nvim/ginit.lua - specific configuration for neovim-qt.


" Plugins: installation, using: https://github.com/junegunn/vim-plug#neovim
" -----------------------------------------------------------------------------

call plug#begin()
Plug 'rose-pine/neovim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/vim-markdown'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'schickling/vim-bufonly'
Plug 'numToStr/FTerm.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'xiyaowong/virtcolumn.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'nvim-tree/nvim-web-devicons'
" In testing:
Plug 'nvim-tree/nvim-tree.lua'

" Color Scheme edition plugins:
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
call plug#end()


" Neovim: editor settings
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


" Plugins: configuration
" -----------------------------------------------------------------------------

" Vim Airline:
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Emmet:
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue,php EmmetInstall

" Coc-nvim
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')


" PyRight: :CocInstall coc-pyright
" Add mypy:python.linting.mypyEnabled
" TBD.

" Better Whitespace:
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" Keybindings:
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

" Config Files:
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

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" FZF:
" ,f: fuzzy on files
nnoremap <leader>f <cmd>lua require('fzf-lua').files()<CR>
nnoremap <leader>o <cmd>lua require('fzf-lua').buffers()<CR>
nnoremap <leader>g <cmd>lua require('fzf-lua').grep()<CR>

" NvimTree
nnoremap <leader>v <cmd>NvimTreeToggle<CR>
nnoremap <leader>r <cmd>NvimTreeFindFile<CR>
