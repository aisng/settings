set t_vb=
set relativenumber
set number
set number relativenumber
set clipboard=unnamedplus
set laststatus=2
set showcmd
colorscheme habamax
syntax on
set t_Co=256 
set termguicolors
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Enable setting the terminal title
set title

" Set the terminal title to the relative path from home
set titlestring=%{expand('%:~')}

" Restore the original terminal title after exiting Vim
autocmd VimLeave * set titlestring=

