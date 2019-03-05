" -----------------------------------------------------------------------------
" Vim editor config values
" -----------------------------------------------------------------------------

" Display line numbers.
set number

" Display the typed command in the right bottom corner.
set showcmd

" Use markers for folding only.
set foldmethod=marker

" Enable vim config in file comments (modeline)
set modeline

" Enable file type detection.
filetype on

" Load the related plugins for different file types.
filetype plugin on

" Syntax highlighting 
syntax on

" Display the help using vertical split.
" Using some "aliases" for that.
cabbrev help vert help
cabbrev h vert h

" Mouse scrolling
set mouse=a

" Open all the buffers in vertical and right
set splitright

" Program used for searches.
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Highlight current line
set cursorline

" Use spaces for tabulatio:n <3
set expandtab
set smarttab

" Who wants an 8 character tab?
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Disable swap files
set noswapfile

" Highlight the search
set hlsearch

" Disable the terminal bell
set visualbell t_vb=

" Dark mode
set background=dark

" -----------------------------------------------------------------------------
" MacVim / gVim vim configuration
" -----------------------------------------------------------------------------

" This only looks good in MacOS
"set guifont=Monaco:h12

" Graphical vim will work with no dialogs.
set guioptions=c

" -----------------------------------------------------------------------------
" Plugin configuration
" -----------------------------------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'https://github.com/vimwiki/vimwiki'
Plug 'mattn/calendar-vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'schickling/vim-bufonly'
call plug#end()

" Color theme
colorscheme gruvbox

" --------------------
" NERDTree      
" --------------------

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1

" Quit vim if NERDTree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" --------------------
" Airline      
" --------------------

" Airline buffers tab
let g:airline#extensions#tabline#enabled = 1

" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'

" --------------------
" Vim Wiki
" --------------------

" Vim Wiki configuration
let g:vimwiki_list = [{'path': '~/.vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Disable TAB for Vim Wiki
let g:vimwiki_table_mappings = 0

" -----------------------------------------------------------------------------
" Key maps
" -----------------------------------------------------------------------------

" Toggle NRDTree with CTRL+N
map <C-n> :NERDTreeToggle<CR>

" Format JSON
map <leader>jsf :% !python -m json.tool<CR>

" Close buffer from nerdtree without exit vim
nnoremap <S-w> :bp\|bd #<CR>

" Remove hlsearch with double CTRL+C
nnoremap <C-c><C-c> :silent! nohls<cr>

" Open the current file's directory in NERDTree with \r
map <leader>r :NERDTreeFind<cr>

" VimWiki, disable fucking backspace
nmap <Leader>wb <Plug>VimwikiGoBackLink

" Navigation between buffers with SHIFT+h and SHIFT+l
map <S-h> :bprev!<CR>
map <S-l> :bnext!<CR>

" Close all the buffers, except the current one
nmap <leader>ca :BufOnly<CR>

" FZF 
nmap <C-p> :FZF<CR>
nmap <leader>hs :Files ~<CR>
nmap <leader>ps :Files .<CR>
nmap <leader>s :Files ~/.vimwiki<CR>

" Enable paste on gvim (Linux)
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>i
vmap <C-C> "+y 
