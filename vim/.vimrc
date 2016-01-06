" Use Vim, not Vi 
set nocompatible

" Backspace the right way 
set backspace=indent,eol,start

" Don't make backup files, that's what git is for
set nobackup

" Make undofiles, pretty useful
set undofile

" Keep 50 lines of command line history
set history=50

" Show the cursor position all the time
set ruler

" Display incomplete commands
set showcmd

" Do incremental searching
set incsearch

" Highlight matching brackets for half a second (5/10ths)
set showmatch
set mat=5

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Sometimes I use a mouse, I know, I'm bad... sometimes.
if has('mouse')
  set mouse=a
endif

" Syntax highlighting, pretty frickin' neat
syntax enable

" Highlighting search results, also pretty frickin' neat
set hlsearch

" Only do this part when compiled with support for autocommands.
" Should be most cases, like my cases.
if has("autocmd")

  " Enable file type detection.
  filetype plugin on

  " Load indent files, because some languages are indent dependent 
  filetype indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  " Autoindenting, pretty handy
  set autoindent

endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Display line numbers on the left side of the window.
" WHY ISN'T THIS ON BY DEFAULT???
set number

" Use spaces instead of tabs when pressing TAB
" 4 spaces, may change later if desired.
set shiftwidth=4
set softtabstop=4
set expandtab

" Set a column marker at 80 or 100 characters, whatever I feel like.
set colorcolumn=80

" Set the width of the line number column
set numberwidth=4

" Add llvm syntax highlighting
augroup filetype
  au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END
