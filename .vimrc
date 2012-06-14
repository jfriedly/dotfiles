"my favoite color scheme
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
set expandtab " use spaces instead of tabs
set smarttab
set ai "auto indent
set si "smart indent
set wrap "wrap lines
au Filetype python retab! " automatically turn tabs into spaces in .py files

"automatically close open tilde brackets (these ones can get annoying) except in
"LaTeX files and Django templates
au BufRead,BufNewFile *.c inoremap { {<esc>o}<esc>O
au BufRead,BufNewFile *.cpp inoremap { {<esc>o}<esc>O
au BufRead,BufNewFile *.js inoremap { {<esc>o}<esc>O

"tell vim to use LaTeX, not some other TeX; turn on spell checker for LaTeX and ReST too
let g:tex_flavor='latex'
au Filetype tex set spell
au Filetype rst set spell

"display line number and character position
set ruler

"load c syntax highlighting when editing interactive c files (for robot project)
au BufRead,BufNewFile *.ic set filetype=c

" my own escape key that isn't as far away as the actual one. Using both jk
" and kj allows me to just jam the keyboard with the speed of one key but
" still have my escape key on home row
inoremap jk <esc>
inoremap kj <esc>

" adds basic text editing and save in normal mode
nmap <cr> i<cr><esc>
nmap <Backspace> i<Backspace><Right><esc>

" overwrites t command to allow an insert single character command.
" can safely overwrite t command because it basically does the same
" thing as f, it just skips to the character before instead
nnoremap t i<Space><esc>r

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
nnoremap <F6> :w<CR>:!git commit -a<CR>
inoremap <F6> <ESC>:w<CR>:!git commit -a<CR>i
" one-key git push
nnoremap <F7> :!git push origin master<CR>
inoremap <F7> <ESC>:!git push origin master<CR>i
