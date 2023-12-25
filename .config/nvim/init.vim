" NeoVim config for Nico
set cursorline
set noswapfile
set autoindent
set number
filetype plugin indent on
set wildmenu
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

syntax on


" Plug: https://github.com/junegunn/vim-plug#neovim
call plug#begin()
Plug 'rose-pine/neovim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'nvim-tree/nvim-web-devicons'
call plug#end()

" PyRight: :CocInstall coc-pyright
"
" Python debugger:
" https://github.com/puremourning/vimspector
"
" Airline replacement, requires a lot of config
" https://github.com/famiu/feline.nvim

colorscheme rose-pine-main

" Key bindings
let mapleader=','

" ,ev: edit CLI configuration
nnoremap <leader>ev :e $MYVIMRC<CR>
" ,gv: edit GUI configuration
nnoremap <leader>gv :e $HOME/.config/nvim/ginit.vim<CR>
" CTRL+h: move to the previous buffer
nmap <C-h> :bprev!<CR>
" CTRL+l: move to the next buffer
nmap <C-l> :bnext!<CR>
" ,v: open file explorer
nnoremap <leader>v <cmd>CHADopen<CR>
" ,f: fuzzy on files
nnoremap <leader>f <cmd>lua require('fzf-lua').files()<CR>
" ,q: close the current buffer
nnoremap <Leader>q :bd<CR>
" CTRL+c CTRL+c: Remove hlsearch
nnoremap <C-c><C-c> :silent! nohls<CR>
