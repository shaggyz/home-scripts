set number
set showcmd
set foldmethod=marker

" Needed for Syntax Highlighting
filetype on
syntax on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Highlight current line
set cursorline

" Use spaces for tabulation <3
set expandtab
set smarttab

" Who wants an 8 character tab?
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Current line highlight
set hlsearch

" run install.sh to get this theme
" $HOME/.vim/colors/molokai.vim
colorscheme molokai