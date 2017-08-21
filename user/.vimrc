" .vimrc

" Setup Plugins :C::
" The next couple lines must precede some code, so keep them at the top here
" Pathogen plugin helps manage other plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Include the system settings
:if filereadable( "/etc/vimrc" )
   source /etc/vimrc
:endif

" Plugin configuration setup
"    NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.*.swp', '\.*.swo', '\.*.swn']
"    vim colors solarized
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

" Misc settings :C::
set nocompatible           " no vi compatibility
filetype plugin indent on  " read in some essential runtime files
syntax on                  " turn on syntax highlighting
" searching
set smartcase              " makes ignorecase only apply to lowercase
set ignorecase             " lets / and ? searches ignore case
set incsearch              " searches as you type
" better tabbing
set shiftwidth=3           " because God uses size 3 tabs
set expandtab              " insert spaces instead of real tabs
set smarttab               " smarter use of tab key (trust me)
" for my orientation
set relativenumber         " gives relative line numbers on leftside
set number                 " gives the current line number on leftside
set ruler                  " shows line and character at bottom right
" command tab completion
set wim=longest,list,full  " wildmode: says how tab completion works
set wildmenu               " extends wildmode to be interactable
" change vim fold settings
set fmr=:fold::,:foldend:: " foldmarker: overwrites {{{ and }}}
set foldmethod=marker      " several other methods exist
" quality of life things
set autoindent             " when starting new line, copy indentation
set history=50             " extend command history
set bs=indent,eol,start    " always allow backspacing
set nojoinspaces           " never double space after periods
set lazyredraw             " don't redraw when it's not needed

" Setup the environment a bit :C::
" set modifiability based on 'read-only' ness
autocmd BufRead * call ProtectReadOnly()
function! ProtectReadOnly()
   if &readonly
      set nomodifiable
   else
      set modifiable
   endif
endfunction

" Syntax Highlighting for strange filenames
au BufRead,BufNewFile screenrc  set syntax=screen
au BufRead,BufNewFile gitconfig set syntax=gitconfig
au BufRead,BufNewFile *.g4      set syntax=antlr4

" Regex Highlighting :fold::
" Highlight custom regex
autocmd BufRead,BufNewFile,WinEnter * call UpdateHighlighting()
let g:note_hl_regex_enabled = 1
let g:default_hl_regex_enabled = 1
let g:extra_hl_regex_enabled = 0
function! UpdateHighlighting()
   call clearmatches()
   if g:note_hl_regex_enabled
      call HlNoteSyntax()
   endif
   if g:default_hl_regex_enabled
      call HlCustomRegex()
   endif
   if g:extra_hl_regex_enabled
      call HlExtraRegex()
   endif
endfunction
" Highlight groups
"    important
:highlight Attention     ctermbg=Magenta  ctermfg=Black
:highlight ConventionErr ctermbg=Red      ctermfg=Black
"    low-key
:highlight Todo          ctermbg=Yellow   ctermfg=Black
:highlight Discrepency   ctermbg=DarkGray
"    notes
:highlight NoteHlRed     ctermbg=DarkRed  ctermfg=White
:highlight NoteHlBlue    ctermbg=DarkBlue ctermfg=White
:highlight NoteHlCyan    ctermbg=Cyan     ctermfg=Black
"    used by vim
:highlight CursorLine    ctermbg=DarkGray ctermfg=White cterm=NONE
function! HlCustomRegex()
   " My code preferences
   "    trailing whitespace
   call matchadd( 'ConventionErr', ' \%#\@!$'    )
   "    real tabs are gross
   call matchadd( 'Discrepency',   '\t'          )
   "    highlights any text in column 86
   call matchadd( 'ConventionErr', '\%86v.'           )
   "    my stub
   call matchadd( 'Attention',     'STUB'        )
   "    other stubs
   call matchadd( 'Todo',          'TODO\c'      )
   call matchadd( 'Todo',          'FIXME\c'     )
   call matchadd( 'Todo',          'XXX'         )
endfunction
function! HlExtraRegex()
   "    Two empty lines is usually unneccessary
   call matchadd( 'Discrepency',   '\n\n\n'      )
   "    highlights double spaces (except after periods)
   call matchadd( 'Discrepency',   '\.\@!\S  \s\@!'   )
   "    highlights new lines at end of file
   call matchadd( 'ConventionErr', '\n\%#\@!\%$'      )
   "    highlights commas with no space after
   call matchadd( 'Discrepency',   ',\S'              )
endfunction
function! HlNoteSyntax()
   call matchadd( 'NoteHlRed',     '^.\{-}:::$'  )
   call matchadd( 'NoteHlRed',     '^.\{-}:R::$' )
   call matchadd( 'NoteHlBlue',    '^.\{-}:B::$' )
   call matchadd( 'NoteHlCyan',    '^.\{-}:C::$' )
endfunction
":foldend::

" My hotkeys :C::
" F1 - toggle line numbers & cursor highlighting
nnoremap <F1> :setlocal number!<cr> :setlocal cursorline!<cr>
" F2 - toggle modifiability
nnoremap <F2> :setlocal modifiable!<cr>
" F3 - toggle defaultRegex
nnoremap <F3> :call ToggleDefaultHlRegex()<cr>
function! ToggleDefaultHlRegex()
   let g:default_hl_regex_enabled = !g:default_hl_regex_enabled
   echo "extra regex =" g:default_hl_regex_enabled
   call UpdateHighlighting()
endfunction
" F4 - toggle extraRegex
nnoremap <F4> :call ToggleExtraHlRegex()<cr>
function! ToggleExtraHlRegex()
   let g:extra_hl_regex_enabled = !g:extra_hl_regex_enabled
   echo "extra regex =" g:extra_hl_regex_enabled
   call UpdateHighlighting()
endfunction
" F5 - toggle customRegex
nnoremap <F5> :checktime<cr>
" F6 - toggle pastemode
nnoremap <F6> :setlocal paste!<cr>
" F8 - toggle NERDTree
nnoremap <F8> :NERDTreeToggle<cr>

" Alias some common words/phrases :C::
"    contact
iabbrev @@g curtisbabnik@gmail.com
iabbrev @@s cbabnik@sfu.ca
iabbrev @@n Curtis Babnik
iabbrev @@p (778)984-2799
iabbrev @@S Author:<cr>Curtis Babnik<cr>cbabnik@sfu.ca<cr>301235515
"    my common spelling mistakes
iabbrev atleast at least
iabbrev seperate separate
iabbrev seperating separating
iabbrev acknowledgement acknowledgment
iabbrev occurance occurence
iabbrev accomodate accommodate
iabbrev accomodation accommodation
iabbrev accomodating accommodating
