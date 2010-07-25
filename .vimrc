fun! Set_colorScheme()
	" IMPORTANT: Uncomment one of the following lines to force
	" using 256 colors (or 88 colors) if your terminal supports it,
	" but does not automatically use 256 colors by default.
	set t_Co=256
	"set t_Co=88
	if (&t_Co == 256 || &t_Co == 88) && !has('gui_running') &&
	  \ filereadable(expand("$HOME/.vim/plugin/guicolorscheme.vim"))
	  " Use the guicolorscheme plugin to makes 256-color or 88-color
	  " terminal use GUI colors rather than cterm colors.
	  runtime! plugin/guicolorscheme.vim
	  GuiColorScheme gentooish
	else
	  " For 8-color 16-color terminals or for gvim, just use the
	  " regular :colorscheme command.
	  colorscheme gentooish
	  set ruler			" show the cursor position all the time
	  set cursorline    " show the cursor line
	endif
endfun

set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

syntax on
" call Set_colorScheme()

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

set history=50		" keep 50 lines of command line history
set showcmd			" display incomplete commands
set incsearch		" do incremental searching
set hlsearch
set number			" show lines number
set paste
set clipboard+=unnamed

set scrolloff=3               " keep at least 3 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set backspace=indent,eol,start  " backspace over all kinds of things
set noerrorbells              " no error bells please
set linebreak                 " wrap at 'breakat' instead of last char
set undolevels=500            " 500 undos
set updatecount=100           " switch every 100 chars
set showmode          		  " Show current vim mode
set wildmenu				  " use a scrollable menu for filename completions

filetype on                   " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins

if has('mouse')
  set mouse=a
endif

set autoindent smartindent
set ttyfast
set magic
set ts=4
set sw=4
set hidden

" --- GUI ---
" Font
set gfn=Terminus\ 8
" Remove toolbar
set guioptions-=T

"minibufferexplorer
"let g:miniBufExplMapWindowNavVim = 1 
"let g:miniBufExplMapWindowNavArrows = 1 
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplModSelTarget = 1

map ; :

"--- windowing -----------------
" be able to scroll through opened files easily with ctrl+j/k
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

let NERDTreeWinPos="right"

fun! ToggleTagList()
	:exe 'TlistToggle' 
	call Set_colorScheme()
endfun

" F6 toggle the taglist
map <silent> <F6> :call ToggleTagList()<CR> 
" F7 toggle NERDTree
map <silent> <F7> :NERDTreeToggle<CR>

" F8 save all buffer
map <silent> <F8> :wa<CR>

" F9 run make
nnoremap <F9> :make<CR>

" F10 prev. buffer
map <silent> <F10> :prev<CR>
" F11 choose buffer number
map <F11> :buffer<CR>:buffer<Space>
" F12 next buffer
map <silent> <F12> :n<CR>

" Those affect all buffers
" Search for <cword> and replace with input() in all open buffers
fun! Replace()
  let s:word = input("Replace " . expand('<cword>') . " with:")
  :exe 'bufdo! %s/' . expand('<cword>') . '/' . s:word . '/ge'
  :unlet! s:word
endfun
map <F4> :call Replace()<CR>

" Undo all buffer
fun! UndoAll()
  :exe 'bufdo! %u' 
endfun
"map <F3> :call UndoAll()<CR>

" Comment; ctrl+c, then c or x to comment/uncomment
au FileType sh,make let b:comment_leader = '# '
au FileType c,cpp,java let b:comment_leader = '// '
au FileType vim let b:comment_leader = '" '
map <silent> <C-C>c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
map <silent> <C-C>x :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

" Low priority filename suffixes for filename completion {{{
set suffixes-=.h        " Don't give .h low priority
set suffixes+=.aux
set suffixes+=.log
set wildignore+=*.dvi
set suffixes+=.bak
set suffixes+=~
set suffixes+=.swp
set suffixes+=.o
set suffixes+=.class
" }}}

call Set_colorScheme()

