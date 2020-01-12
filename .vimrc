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

" Display manpages without exiting vim
set keywordprg=:Man

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

" Enable backspace on some terminals (urxvt, for example)
set backspace=2

" Syntax highlighting
syntax on

" Mouse scrolling
set mouse=a

" Program used for searches.
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Highlight current line
set cursorline

" Use spaces for tabulation <3
set expandtab

" Tabs with four spaces
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

" Improving? autocompletion
set wildmode=longest,list,full
set wildmenu

" Use <intro> to select in omnicompletion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Disable preview window for omnicompletion
set completeopt-=preview

" This only looks good in MacOS
if has("gui_macvim")
    set guifont=Hack\ Nerd\ Font\ Mono:h12
    set pythonthreehome=/opt/local/Library/Frameworks/Python.framework/Versions/3.6
    set pythonthreedll=/opt/local/Library/Frameworks/Python.framework/Versions/3.6/lib/libpython3.6m.dylib
endif

" Graphical vim will work with no dialogs.
set guioptions=c

" Omni complete, for development
set omnifunc=syntaxcomplete#Complete

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
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'schickling/vim-bufonly'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'shaggyz/php-documentor-vim'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'vim-vdebug/vdebug'
Plug 'mileszs/ack.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'dansomething/vim-eclim'
Plug 'ryanoasis/vim-devicons'
Plug 'joshdick/onedark.vim'
Plug 'lumiliet/vim-twig'
Plug 'posva/vim-vue'
Plug 'machakann/vim-sandwich'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'mtdl9/vim-log-highlighting'
Plug 'janiczek/vim-latte'
Plug 'fatih/vim-go'
Plug 'vim-vdebug/vdebug'
call plug#end()

" Manpages inside vim
runtime! ftplugin/man.vim

" Color theme
" colorscheme gruvbox
" colorscheme onedark
colorscheme iceberg

" --------------------
" Ack search
" --------------------

let g:ackprg = 'ag --silent --ignore "tags" --vimgrep --smart-case'
cnoreabbrev ag Ack!

" --------------------
" vdebug
" --------------------

let g:vdebug_options = {
    \'break_on_open': 0
\}


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

" Snippets directory: ~/.vim/snippets
let g:snipMate = {}
let g:snipMate.snippet_version = 1

" Display the description in the snip popup (CTR-R + TAB)
let g:snipMate.description_in_completion = 1

" --------------------
" PHP QA
" --------------------

" Set the codesniffer args
let g:phpqa_codesniffer_args = '--standard=PSR2'

" Disable phpmd on save (there is a bug here)
let g:phpqa_messdetector_autorun = 0

" --------------------
" NERDTree
" --------------------

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1

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
autocmd FileType html,css,vue EmmetInstall

" -----------------------------------------------------------------------------
" Auto-commands for file types
" -----------------------------------------------------------------------------

" python - run the current buffer content with CTRL-B (build)
autocmd FileType python nnoremap <buffer> <C-b> :exec '!clear ; venv/bin/python' shellescape(@%, 1)<CR>

" Remove the trailing spaces in these file types
autocmd FileType c,cpp,python,php,muttrc,xdefaults,css,html,config,vim autocmd BufWritePre <buffer> %s/\s\+$//e

" Open the current html file with the default browser
autocmd FileType html nnoremap <buffer> <C-b> :!exec xdg-open %<CR>

" Format html code with \ fh
autocmd FileType html nnoremap <buffer> <leader>fh :!exec tidy -mi -html -wrap 0 %<CR>

" Export the current markdown file to PDF with pandoc
if has("gui_macvim")
    " MacOS
    autocmd FileType markdown,vimwiki nnoremap <buffer> <leader>pa :exec '!pandoc % --pdf-engine=xelatex -o ~/Downloads/vim-output.pdf -V geometry:margin=0.7in'<CR>
else
    " *nix
    autocmd FileType markdown,vimwiki nnoremap <buffer> <leader>pa :exec '!pandoc % --latex-engine=xelatex -o ~/Downloads/vim-output.pdf -V geometry:margin=0.7in'<CR>
endif

" -----------------------------------------------------------------------------
" Key maps
" -----------------------------------------------------------------------------

" URL encode/decode selection
vnoremap <leader>en :!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>
vnoremap <leader>de :!python -c 'import sys,urllib;print urllib.unquote(sys.stdin.read().strip())'<cr>

" Toggle NERDTree with \ + N
map <leader>n :NERDTreeToggle<CR>

" Format JSON
map <leader>jsf :% !python -m json.tool<CR>

" Close buffers with \wq
nnoremap <leader>wq :bp\|bd #<CR>

" Remove hlsearch with double CTRL+c
nnoremap <C-c><C-c> :silent! nohls<cr>

" Open the current file's directory in NERDTree with \r
map <leader>r :NERDTreeFind<cr>

" VimWiki, disable fucking backspace
nmap <Leader>wb <Plug>VimwikiGoBackLink

" Navigation between buffers with CTRL+h and CTRL+l
nmap <C-h> :bprev!<CR>
nmap <C-l> :bnext!<CR>

" Close all the buffers, except the current one
nmap <leader>ca :BufOnly<CR>

" FZF select file from current dir.
nmap <C-p> :Files<CR>

" FZF select from open buffers
nmap <C-o> :Buffers<CR>

" FZF vimwiki search: /s (files)
nmap <leader>s :Files ~/.vimwiki<CR>

" Idea for vimwiki search:
" grep -ril Linux . | fzf

" FZF list git modified files (fzf git status)
nmap <leader>gs :GFiles?<CR>

" FZF list the command history
nmap <leader>h :History:<CR>

" Enable paste on gvim (Linux)
imap <C-V> "+gP
vmap <C-C> "+y

" Open vimrc in a vertical split
nnoremap <leader>ev :e $MYVIMRC<cr>

" Exit from insert mode when 'jk' is typed.
inoremap jk <esc>
