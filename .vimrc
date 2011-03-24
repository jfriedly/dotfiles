" my favorite color scheme
colo zellner
" turn on colors
syntax on

" remember 700 lines of history
set history=700 

" ignore case when searching unless it contains uppercase letters
set ignorecase
set smartcase

" make search act like search in Firefox
set incsearch

" turn off backups
set nobackup

" smart tabbing
set smarttab
set ai "auto indent
set si "smart indent
set wrap "wrap lines

" allows you to move using standard mvmt keys in insert mode
inoremap <C-h> <Left>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-l> <Right>

" automatically closes all your opening stuff. '{' will put a new line in between
inoremap <C-(> ()<esc>i
inoremap <C-]> []<esc>i
inoremap <C-{> {<esc>o}<esc>O 
inoremap <C-'> ''<esc>i
inoremap <C-"> ""<esc>i
inoremap <C-<> <><esc>i

" uses windows-like copying, pasting, and saving
inoremap <C-z> <esc>ui
inoremap <C-v> <esc>pi
vnoremap <C-c> y
vnoremap <C-x> d
inoremap <C-c> <esc>v
inoremap <C-x> <esc>v
inoremap <C-s> <esc>:w<cr>i

" adds basic text editing and save in normal mode
nmap <cr> i<cr><esc>
nmap <Backspace> i<Backspace><Right><esc>
nmap <C-s> :w<cr>

" no need to be compatible with vi
set nocompatible

" set tabs to 4 spaces and auto tabs to four spaces
set shiftwidth=4
set tabstop=4

" set the title in terminals
set title

" enable cmdline autocomplete
set wildmenu 

" know what type of file I'm editing
filetype plugin on

" one-key git commit
nnoremap <F5> :w<CR>:!git commit -a<CR>
inoremap <F5> <ESC>:w<CR>:!git commit -a<CR>i
" one-key git push
nnoremap <F6> :!git push origin master<CR>
inoremap <F6> <ESC>:!git push origin master<CR>i

" lets me skip to newline even if there's stuff after the cursor
inoremap <C-o> <esc>o
