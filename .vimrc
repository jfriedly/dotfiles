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

set expandtab " use spaces instead of tabs
set autoindent
set smartindent
set wrap "wrap lines
au Filetype python retab! " automatically turn tabs into spaces in .py files
au Filetype python set makeprg="pep8 && pylint -E"

"automatically close open tilde brackets (these ones can get annoying) except in
"LaTeX files and Django templates
au BufRead,BufNewFile *.c inoremap <buffer> { {<esc>o}<esc>O
au BufRead,BufNewFile *.cpp inoremap <buffer> { {<esc>o}<esc>O
au BufRead,BufNewFile *.js inoremap <buffer> { {<esc>o}<esc>O

"tell vim to use LaTeX, not some other TeX; turn on spell checker for LaTeX
"and ReStructuredText too
let g:tex_flavor='latex'
au Filetype tex set spell
au Filetype rst set spell
"If I'm in ReST, allow easy LaTeX injection with these macros.  @a is inline
"LaTeX and @b is regular LaTeX
au Filetype rst nnoremap @a i:rl:`$$`<esc>hi
au Filetype rst nnoremap @b i:rl:`\[\]`<esc>hhi

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
" paradigm recommended this one, but it makes restructured text unbearable.
" Removed.
" filetype indent on

" one-key git commit
nnoremap <F6> :w<CR>:!git commit -a<CR>
inoremap <F6> <ESC>:w<CR>:!git commit -a<CR>i
" one-key git push
nnoremap <F7> :!git push origin master<CR>
inoremap <F7> <ESC>:!git push origin master<CR>i

" if I'm in the command line window, make escape able to close it
au CmdwinEnter * nnoremap <buffer> <ESC> :q<cr>

" mark trailing spaces with this ugly character to make them hard to miss
set list
set listchars=trail:·

"
highlight Folded ctermbg=darkgrey ctermfg=green

"load c syntax highlighting when editing nesC files (for CSE-5473 project)
au BufRead,BufNewFile *.nc set filetypec

" have :tabf only show things in present directory, NOT /usr/include as it
" normally is by default.  See ":help :tabf" -> ":help 'path'"
set path=.
