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


" PyRight: :CocInstall coc-pyright
" Python debugger:
" https://github.com/puremourning/vimspector
" Plug: https://github.com/junegunn/vim-plug#neovim
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
call plug#end()


colorscheme rose-pine-main


" Vim Airline configuration
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" CHADTree configuration: this is not working
let g:chadtree_settings = { "theme.text_colour_set": "env", "keymap.jump_to_current": ["<leader>-r"]}


" Read .bashrc and friend for the integrated terminal
set shell=bash\ -l


" Emmet configuration
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue,php EmmetInstall


" Require the ~/.config/nvim/lua/config.lua config file
lua require('config')


" Key bindings
let mapleader=','

" ,ev: edit CLI configuration
nnoremap <leader>ev :e $MYVIMRC<CR>
" ,gv: edit GUI configuration
nnoremap <leader>gv :e $HOME/.config/nvim/ginit.vim<CR>
" ,lv: edit LUA configuration
nnoremap <leader>lv :e $HOME/.config/nvim/lua/config.lua<CR>

" Coc keymaps
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>yy <Plug>(coc-type-definition)
nmap <silent> <leader>im <Plug>(coc-implementation)
nmap <silent> <leader>re <Plug>(coc-references)

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

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
" ,ca: Close all the buffers, except the current one
nmap <leader>ca :BufOnly<CR>
" CTRL+i: toggle the terminal
nnoremap <C-i> <cmd>lua require("FTerm").toggle()<CR>
tnoremap <C-i> <C-n><CMD>lua require("FTerm").toggle()<CR>
