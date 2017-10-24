" github.com/ayip001
" ~/.vimrc
"
" defines behavior for vim

set number ai background=dark
syntax on
" for 42
" set tabstop=4
set tabstop=8
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
