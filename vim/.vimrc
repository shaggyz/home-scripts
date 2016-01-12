" Misc stuff
set number
set showcmd
set foldmethod=marker

" Needed for Syntax Highlighting and stuff
filetype on
syntax on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Highlight current line
set cursorline

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Current line highlight
set hlsearch

" $HOME/.vim/colors/molokai.vim
colorscheme molokai

"
" Plugin configuration
"

" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" NERDTree
map <C-n> :NERDTreeToggle<CR>

