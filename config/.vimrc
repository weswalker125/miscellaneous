set ai
set autoread
set encoding=utf8
set hlsearch
set history=500
set ignorecase
set noswapfile
set shiftwidth=4
set si
set smarttab
set tabstop=4
set wrap

filetype plugin on
filetype indent on
syntax enable

" :W sudo save.
command W w !sudo tee % > /dev/null
