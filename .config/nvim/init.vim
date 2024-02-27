" NeoVim config for Nico
set cursorline
set noswapfile
set autoindent
set number
set mouse=a
set wildmenu
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nofoldenable
set conceallevel=2


syntax on
filetype plugin indent on


" Plug: https://github.com/junegunn/vim-plug#neovim
call plug#begin()
Plug 'rose-pine/neovim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'preservim/vim-markdown'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()


" PyRight: :CocInstall coc-pyright
"
" Python debugger:
" https://github.com/puremourning/vimspector


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


" Vim Airline configuration
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" Read .bashrc and friend for the integrated terminal
set shell=bash\ -l


" Neovide configuration (GUI)
if exists("g:neovide")
    " Font: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CommitMono.zip
    " set guifont=CommitMono\ Nerd\ Font\ Mono:h14
    set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h12.5
    " Additional cursor particle effect
    let g:neovide_cursor_vfx_mode = "sonicboom"
    " Cursor animation time
    let g:neovide_cursor_trail_size = 0.2
    " Scrolling animation time
    let g:neovide_scroll_animation_length = 0.2
endif
