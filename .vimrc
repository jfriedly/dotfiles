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
set smarttab
set ai "auto indent
set si "smart indent
set wrap "wrap lines

"automatically close open squigly brackets (these ones can get annoying) except "in LaTeX files
inoremap { {<esc>o}<esc>O
au BufRead,BufNewFile *.tex inoremap { {

" Ctrl-z only works in visual or normal mode regularly, so this makes it undo
" in insert mode
inoremap <C-z> <esc>ui

" Ctrl-v is the same as <esc>V and doesn't work on windows so I'd just as
" rather have it paste
inoremap <C-v> <esc>pi

" Ctrl-c only interrupts current searches, so we'll have it basically just
" copy when in visual mode
vnoremap <C-c> y

" my own escape key that isn't as far away as the actual one. Using both jk
" and kj allows me to just jam the keyboard with the speed of one key but
" still have my escape key on home row
inoremap jk <esc>
inoremap kj <esc>
vnoremap jk <esc>
vnoremap kj <esc>

" adds basic text editing and save in normal mode
nmap <cr> i<cr><esc>
nmap <Backspace> i<Backspace><Right><esc>

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

" lets me skip to newline even if there's stuff after the cursor
inoremap <C-o> <esc>o
