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
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/vim-markdown'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'schickling/vim-bufonly'
Plug 'numToStr/FTerm.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'ntpeters/vim-better-whitespace'
call plug#end()


" Neovim: editor settings
" -----------------------------------------------------------------------------

set tabstop=4
set shiftwidth=4
set softtabstop=4

set cursorline
set number
set conceallevel=2

set noswapfile
set autoindent
set mouse=a
set wildmenu
set expandtab
set nofoldenable

filetype plugin indent on
syntax on

colorscheme rose-pine-main

"set shell=bash\ -l

" ~/.config/nvim/lua/config.lua
lua require('config')


" Plugins: configuration
" -----------------------------------------------------------------------------

" Vim Airline:
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" CHADTree: keybinding not working ATM
let g:chadtree_settings = { "theme.text_colour_set": "env", "keymap.jump_to_current": ["<leader>-r"]}

" Emmet:
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue,php EmmetInstall

" PyRight: :CocInstall coc-pyright
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
" ,q: close the current buffer
nnoremap <Leader>q :bd<CR>
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
nmap <silent> <leader>re <Plug>(coc-references)

" CHADTree:
" ,v: open file explorer
nnoremap <leader>v <cmd>CHADopen<CR>

" FZF:
" ,f: fuzzy on files
nnoremap <leader>f <cmd>lua require('fzf-lua').files()<CR>
nnoremap <leader>o <cmd>lua require('fzf-lua').buffers()<CR>
nnoremap <leader>g <cmd>lua require('fzf-lua').grep()<CR>
