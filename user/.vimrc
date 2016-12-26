" .vimrc

" Include the system settings
:if filereadable( "/etc/vimrc" )
   source /etc/vimrc
:endif

set nocompatible        " no vi compatibility
filetype plugin indent on

syntax on

set autoindent
set history=50
set ruler
set incsearch

set bs=indent,eol,start " always allow backspacing
set nojoinspaces        " never double space after periods

" converts only lowercase searches to ignorecase
set smartcase
set ignorecase

" better tabbing
set shiftwidth=3
set expandtab
set smarttab

" completing commands with tab
set wildmode=longest,list,full
set wildmenu

" overwrites the default vim foldmarkers {{{ , }}}
set foldmarker=:fold::,:foldend::
set foldmethod=marker

" set modifiability based on 'read-only' ness
autocmd BufRead * call ProtectReadOnly()
function! ProtectReadOnly()
   if &readonly
      set nomodifiable
   else
      set modifiable
   endif
endfunction

" Highlighting :fold::
" Highlight custom regex
autocmd BufRead,BufNewFile,WinEnter * call UpdateHighlighting()
let g:note_hl_regex_enabled = 1
let g:default_hl_regex_enabled = 1
let g:extra_hl_regex_enabled = 0
function UpdateHighlighting()
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
:highlight Attention     ctermbg=Magenta  ctermfg=Black
:highlight ConventionErr ctermbg=Red      ctermfg=Black
:highlight Discrepency   ctermbg=DarkGray
:highlight NoteHlRed     ctermbg=DarkRed  ctermfg=White
:highlight NoteHlBlue    ctermbg=DarkBlue ctermfg=White
:highlight NoteHlCyan    ctermbg=Cyan     ctermfg=Black
function HlCustomRegex()
   " My code preferences
   "    trailing whitespace
   call matchadd( 'ConventionErr', ' \%#\@!$'    )
   "    real tabs are gross
   call matchadd( 'Discrepency',   '\t'          )
   "   highlights any text in column 86
   call matchadd( 'ConventionErr', '\%86v.'           )
   "   my stub
   call matchadd( 'Attention',     'STUB'        )
   "   other stubs 'STUB' Todo doesn't exist anymore
   "call matchadd( 'Todo',          'TODO\c'      )
   "call matchadd( 'Todo',          'FIXME\c'     )
   "call matchadd( 'Todo',          'XXX'         )
endfunction
function HlExtraRegex()
   "   Two empty lines is usually unneccessary
   call matchadd( 'Discrepency',   '\n\n\n'      )
   "   highlights double spaces (except after periods)
   call matchadd( 'Discrepency',   '\.\@!\S  \s\@!'   )
   "   highlights new lines at end of file
   call matchadd( 'ConventionErr', '\n\%#\@!\%$'      )
   "   highlights commas with no space after
   call matchadd( 'Discrepency',   ',\S'              )
endfunction
function HlNoteSyntax()
   call matchadd( 'NoteHlRed',     '^.\{-}:::$'  )
   call matchadd( 'NoteHlRed',     '^.\{-}:R::$' )
   call matchadd( 'NoteHlBlue',    '^.\{-}:B::$' )
   call matchadd( 'NoteHlCyan',    '^.\{-}:C::$' )
endfunction
function ToggleDefaultHlRegex()
   if g:default_hl_regex_enabled
      let g:default_hl_regex_enabled = 0
   else
      let g:default_hl_regex_enabled = 1
   endif
   call UpdateHighlighting()
endfunction
function ToggleExtraHlRegex()
   if g:default_hl_regex_enabled
      let g:extra_hl_regex_enabled = 0
   else
      let g:extra_hl_regex_enabled = 1
   endif
   call UpdateHighlighting()
endfunction
":foldend::

" My hotkeys :C::
" F1 - toggle line numbers
nnoremap <F1> :setlocal number!<cr>
" F2 - toggle modifiability
nnoremap <F2> :setlocal modifiable!<cr>
" F3 - toggle defaultRegex
nnoremap <F3> :call ToggleDefaultHlRegex()<cr>
" F4 - toggle extraRegex
nnoremap <F4> :call ToggleExtraHlRegex()<cr>
" F5 - toggle customRegex
nnoremap <F5> :checktime<cr>
" F6 - toggle pastemode
nnoremap <F6> :setlocal paste!<cr>

" alias some common words/phrases :C::
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
