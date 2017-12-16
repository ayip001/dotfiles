" github.com/ayip001
" ~/.vimrc
"
" defines behavior for vim

filetype plugin indent on

autocmd Filetype tex setl updatetime=1

set number ai background=dark
syntax on
set tabstop=4
set shiftwidth=4
autocmd BufNewFile,BufRead *.js,*.es6,*.jsx set filetype=javascript.jsx
autocmd FileType javascript.jsx setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
set expandtab
" set tabstop=8
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" LaTex Live Preview
autocmd Filetype tex setl updatetime=1000
let g:livepreview_previewer = 'mupdf'

" vim-plug package
call plug#begin('~/.vim/plugged')

" A Vim Plugin for Lively Previewing LaTeX PDF Output
Plug 'xuhdev/vim-latex-live-preview'

" Web developer
Plug 'mattn/emmet-vim'

call plug#end()
