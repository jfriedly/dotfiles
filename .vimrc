" My favoite color scheme.
color zellner
" Turn on colors.
syntax on

" Remember 700 lines of history.
set history=700

" Ignore case when searching unless it contains uppercase letters.
set ignorecase
set smartcase

" Make search act like search in Firefox
set incsearch

" Turn off backups
set nobackup

" Use spaces instead of tabs
set expandtab
set autoindent
set smartindent
set wrap "wrap lines

" Python commands.
augroup python
    " Remove all other autocmds.
    autocmd!
    " Automatically turn tabs into spaces in .py files.
    autocmd Filetype python retab!
    " Make with pep8 first, then with pylint. Pylint requires an rcfile
    " though.
    autocmd Filetype python setlocal makeprg=pep8\ %;pylint\ --reports=n\ --output-format=parseable\ --rcfile=~/.pylintrc\ %
    " This errorformat isn't perfect for either pep8 or pylint, but it works
    " decently for both.
    autocmd Filetype python setlocal errorformat=%f:%l%m
augroup end

" Automatically close open tilde brackets (these ones can get annoying) in
" C, C++, and JavaScript files.
au BufRead,BufNewFile *.c inoremap <buffer> { {<esc>o}<esc>O
au BufRead,BufNewFile *.cpp inoremap <buffer> { {<esc>o}<esc>O
au BufRead,BufNewFile *.js inoremap <buffer> { {<esc>o}<esc>O

" Tell vim to use LaTeX, not some other TeX; turn on spell checker for LaTeX
" and ReStructuredText too.
let g:tex_flavor='latex'
au Filetype tex set spell
au Filetype rst set spell

" If I'm in ReST, allow easy LaTeX injection with these macros.  @a is inline
" LaTeX and @b is regular LaTeX.
au Filetype rst nnoremap @a i:rl:`$$`<esc>hi
au Filetype rst nnoremap @b i:rl:`\[\]`<esc>hhi

" Display line number and character position.
set ruler

" Load C syntax highlighting when editing interactive c files (for robot
" project).
au BufRead,BufNewFile *.ic set filetype=c

" Load C syntax highlighting when editing nesC files (for CSE-5473 project).
au BufRead,BufNewFile *.nc set filetype=c

" My own escape key that isn't as far away as the actual one. Using both jk
" and kj allows me to just jam the keyboard with the speed of one key but
" still have my escape key on home row.
inoremap jk <esc>
inoremap kj <esc>

" Allow backspacing in normal mode.
nmap <Backspace> i<Backspace><Right><esc>

" Insert a single character with the enter key in normal mode.
nnoremap <CR> i<Space><esc>r

" No need to be compatible with vi.
set nocompatible

" Set tabs to 4 spaces and auto tabs to four spaces.
set shiftwidth=4
set tabstop=4

" Set the title in terminals.
set title

" Enable cmdline autocomplete.
set wildmenu

" Know what type of file I'm editing.
filetype plugin on
" Paradigm recommended this one, but it makes restructured text unbearable.
" Removed.
" filetype indent on

" If I'm in the command line window, make escape able to close it.
au CmdwinEnter * nnoremap <buffer> <ESC> :q<cr>

" Mark trailing spaces with this ugly character to make them hard to miss.
set list
set listchars=trail:·

" The default fold colors are terrible.
highlight Folded ctermbg=darkgrey ctermfg=green

" Have :tabf only show things in present directory, NOT /usr/include as it
" normally is by default.  See ":help :tabf" -> ":help 'path'".
set path=.,,

" Set the spacebar to my leader key.
let mapleader = " "
