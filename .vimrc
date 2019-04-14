" -----------------------------------------------------------------------------
" Vim editor config values
" -----------------------------------------------------------------------------

" It was a long journey, vi
set nocompatible

" Unicode for everything
set encoding=UTF-8

" Display line numbers.
set number

" Display the typed command in the right bottom corner.
set showcmd

" Use markers for folding only.
set foldmethod=marker

" Disable folding
set nofoldenable

" Enable vim config in file comments (modeline)
set modeline

" Suppress shell output
set shellpipe=>

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

" Use spaces for tabulation <3
set expandtab
" set smarttab

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
if has("gui_macvim")
    set guifont=Monaco:h12
endif

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
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'schickling/vim-bufonly'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'joonty/vim-phpqa'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'sumpygump/php-documentor-vim'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'vim-vdebug/vdebug'
Plug 'mileszs/ack.vim'
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Color theme
colorscheme gruvbox

" --------------------
" Ack search
" --------------------

let g:ackprg = 'ag --silent --ignore "tags" --vimgrep --smart-case'
cnoreabbrev ag Ack!
cnoreabbrev aG Ack!
cnoreabbrev Ag Ack!
cnoreabbrev AG Ack!

" --------------------
" vdebug
" --------------------

let g:vdebug_options = {
    \'break_on_open': 0
\}

" --------------------
" PHP namespaces
" --------------------

function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction

autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

" --------------------
" PHP Documentor
" --------------------

au BufRead,BufNewFile *.php inoremap <buffer> <leader>co :call PhpDoc()<CR>
au BufRead,BufNewFile *.php nnoremap <buffer> <leader>co :call PhpDoc()<CR>
au BufRead,BufNewFile *.php vnoremap <buffer> <leader>co :call PhpDocRange()<CR>

let g:pdv_cfg_Author = 'Nicolás Palumbo <n@xinax.net>'
let g:pdv_cfg_ClassTags = ["author"]

" --------------------
" SnipMate
" --------------------

let g:snipMate = {}
let g:snipMate.snippet_version = 1

" Display the description in the snip popup (CTR-R + TAB)
let g:snipMate.description_in_completion = 1

" --------------------
" PHP QA
" --------------------

" SetDeopletDeopletee the codesniffer args
let g:phpqa_codesniffer_args = '--standard=PSR2'

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

" Enable powerline patched fonts.
" Patched fonts retrieved from: https://github.com/powerline/fonts
let g:airline_powerline_fonts = 1

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

" --------------------
" Vim Emmet
" --------------------

" <C-Y> , (autocomplete/trigger command, please note the comma)
" Enable emmet only in html and css files.
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" -----------------------------------------------------------------------------
" Auto-commands for file types
" -----------------------------------------------------------------------------

" python - run the current buffer content with CTRL-B (build)
autocmd FileType python nnoremap <buffer> <C-b> :exec '!clear ; venv/bin/python' shellescape(@%, 1)<CR>

" Remove the trailing spaces in these file types
autocmd FileType c,cpp,python,php,muttrc,xdefaults,css,html,config,vim autocmd BufWritePre <buffer> %s/\s\+$//e

" -----------------------------------------------------------------------------
" Key maps
" -----------------------------------------------------------------------------

" Toggle NERDTree with CTRL+N
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
