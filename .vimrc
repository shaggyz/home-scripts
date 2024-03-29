" -----------------------------------------------------------------------------
" Vim editor config values
" -----------------------------------------------------------------------------

" Features
set nocompatible
set nofoldenable
set modeline
set shellpipe=>
set autoindent
set cursorline
set noswapfile
set visualbell t_vb=
set guioptions=c
set grepprg=grep\ -nH\ $*
set termguicolors

filetype on
filetype plugin on
syntax on

" Editor
set encoding=UTF-8
set mouse=a
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" UI
set number
set showcmd
set foldmethod=marker
set background=dark

" Enable backspace on some terminals (urxvt, for example)
set backspace=2

" command autocompletion
set wildmode=longest,list,full
set wildmenu
set completeopt-=preview

" Workaround for pink cursor: https://github.com/vim/vim/issues/3471
":set t_Cs=

" map leader to ,
let mapleader = ","

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
Plug 'vim-airline/vim-airline'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'schickling/vim-bufonly'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'mileszs/ack.vim'
Plug 'machakann/vim-sandwich'
Plug 'mtdl9/vim-log-highlighting'
Plug 'justmao945/vim-clang'
Plug 'chr4/nginx.vim'
Plug 'leafgarland/typescript-vim'
Plug 'fedorenchik/qt-support.vim'
Plug 'itspriddle/vim-shellcheck'
Plug 'jparise/vim-graphql'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'rose-pine/vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'lepture/vim-jinja'

call plug#end()

" Manpages inside vim
runtime! ftplugin/man.vim
set keywordprg=:Man

" Color theme
colorscheme rosepine

" Ack search
let g:ackhighlight = 1
let g:ackprg = 'ag --silent --ignore "tags" --vimgrep --smart-case'
cnoreabbrev ag Ack!

" vim airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline_solarized_bg='dark'

" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'

" SnipMate: Snippets directory: ~/.vim/snippets
let g:snipMate = {}
let g:snipMate.snippet_version = 1
" Display the description in the snip popup (CTR-R + TAB)
let g:snipMate.description_in_completion = 1

" NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '.git', '.idea', 'tags', '.venv']

" Vim Wiki
let g:vimwiki_list = [{'path': '~/.vimwiki/personal/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_url_maxsave = 0
let g:vimwiki_table_mapping = 0

" Vim Emmet
" <C-Y> , (autocomplete/trigger command, please note the comma)
" Enable emmet only in html and css files.
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue,php EmmetInstall

" -----------------------------------------------------------------------------
" CoC for some languages
" -----------------------------------------------------------------------------

" python (:CocInstall coc-pyright)
autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']


" -----------------------------------------------------------------------------
" Auto-commands for file types
" -----------------------------------------------------------------------------

" Remove trailing spaces in certain file types.
autocmd FileType sh,javascript,ts,vue,c,cpp,java,php,vimwiki,make,markdown autocmd BufWritePre <buffer> %s/\s\+$//e
" python - run the current buffer content with CTRL-B (build)
autocmd FileType python nnoremap <buffer> <leader>run :exec '!clear ; python3' shellescape(@%, 1)<CR>
" Remove the trailing spaces in these file types
autocmd FileType c,cpp,python,php,muttrc,xdefaults,css,html,config,vim autocmd BufWritePre <buffer> %s/\s\+$//e
" Open the current html file with the default browser
autocmd FileType html nnoremap <buffer> <C-b> :!exec xdg-open %<CR>
" Format html code with \ fh
autocmd FileType html nnoremap <buffer> <leader>fh :!exec tidy -mi -html -wrap 0 %<CR>
" Format xml code with \ fx
autocmd FileType xml nnoremap <buffer> <leader>fx :!exec tidy -mi -xml -wrap 0 %<CR>
" Export the current markdown file to PDF with pandoc
autocmd FileType markdown,vimwiki nnoremap <buffer> <leader>pa :exec '!pandoc "%" --pdf-engine=xelatex -o ~/Downloads/vim-output.pdf -V geometry:margin=0.7in'<CR>
autocmd FileType markdown,vimwiki nnoremap <buffer> <leader>ph :exec '!pandoc -s -f markdown -t html5 -o ~/Downloads/vim-output.html -c ~/Downloads/css/bootstrap.min.css %'<CR>
" Use <intro> to select in omnicompletion
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" 2-spaces tabs for some file types
autocmd FileType vue setlocal shiftwidth=2 tabstop=2
autocmd FileType json setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" Colorize requirements.txt files for python
autocmd BufRead,BufNewFile requirements.txt set syntax=config

" -----------------------------------------------------------------------------
" Tag generation
" -----------------------------------------------------------------------------

" Generate ctags everytime we save a C file
au BufWritePost *.c,*.h,*.cpp silent! !eval '/opt/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --fields=+aimS' &

" Generate ctags everytime we save a python file
au BufWritePost *.py silent! !eval 'ctags -R --fields=+l --languages=python --python-kinds=-iv --exclude=venv/bin/* --fields=+aimS' &
" TODO: check this and not only when saving!!: ctags -R --fields=+laimSz --languages=python --python-kinds=+cfmvi

" -----------------------------------------------------------------------------
" Key maps
" -----------------------------------------------------------------------------

" CTRL+t    -> Back to the shell
nmap <leader>t :terminal<CR>
" ,en       -> URL Encode selection
vnoremap <leader>en :!python3 -c 'import sys,urllib;print(urllib.quote(sys.stdin.read().strip()))'<cr>
" ,de       -> URL Decode selection
vnoremap <leader>de :!python3 -c 'import sys,urllib;print(urllib.unquote(sys.stdin.read().strip()))'<cr>
" ,n        -> Toggle NERDTree
map <leader>n :NERDTreeToggle<CR>
" ,r        -> Open the current file's directory in NERDTree
map <leader>r :NERDTreeFind<cr>
" ,jsf      -> Format JSON
map <leader>jsf :% !python -m json.tool<CR>
" ,q        -> Close the current buffer
nnoremap <Leader>q :Bdelete<CR>
" CTRL+c CTRL+c -> Remove hlsearch
nnoremap <C-c><C-c> :silent! nohls<cr>
" CTRL+h    -> Move to the previous buffer
nmap <C-h> :bprev!<CR>
" CTRL+l    -> Move to the next buffer
nmap <C-l> :bnext!<CR>
" ,ca       -> Close all the buffers, except the current one
nmap <leader>ca :BufOnly<CR>
" ,f        -> FZF select file name from current dir.
nmap <leader>f :Files<CR>
" ,C        -> Search file contents in the current directory
nmap <leader>C :Ag<CR>
" ,o        -> FZF select from open buffers
nmap <leader>o :Buffers<CR>
" ,s        -> FZF vimwiki search (file names)
nmap <leader>s :Files ~/.vimwiki<CR>
" ,S        -> Vimwiki search (content)
nmap <leader>S :cd ~/.vimwiki/personal \| Ag<CR>
" ,gs       -> FZF list git modified files (fzf git status)
nmap <leader>gs :GFiles?<CR>
" ,h        -> FZF list the command history
nmap <leader>h :History:<CR>
" ,ev       -> Open vimrc in a split
nnoremap <leader>ev :e $MYVIMRC<cr>
" ,er       -> Reload vimrc configuration
nnoremap <leader>er :source $MYVIMRC<cr>

" -----------------------------------------------------------------------------
" OSX-specific configuration
" -----------------------------------------------------------------------------

if has("gui_macvim")
    set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h13
endif
