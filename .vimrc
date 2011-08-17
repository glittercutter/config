set nocompatible

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Snipmate fix on windows
if has("win32")
	"source $VIMRUNTIME/after/plugin/snipMate.vim
endif


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set scrolloff=3               " keep at least 3 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set backspace=indent,eol,start  " backspace over all kinds of things
set noerrorbells              " no error bells please
set linebreak                 " wrap at 'breakat' instead of last char
set undolevels=200
set updatecount=100           " switch every 100 chars
set ttyfast                   " we have a fast terminal
filetype on                   " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins
set magic                     " Enable the "magic"
set cursorline                " show the cursor line
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number		" show lines number
set paste
set clipboard+=unnamed
set guioptions-=T	" remove GUI
set guioptions-=b
set guioptions-=m

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=1 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=1

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction


"--- NERDTree -----------------
let NERDTreeWinPos="left"
map <silent> <F2> :NERDTreeToggle<CR>

"--- TagsList -----------------
let Tlist_Ctags_Cmd='C:/ctags58/ctags.exe'
let Tlist_Sort_Type = "name"
let Tlist_Compact_Format = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Show_Menu = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_Display_Prototype = 1


function ToggleTagList()
	:exe 'TlistToggle'
	:call SetColorscheme()
endfun
map <F3> :call ToggleTagList()<CR>


function ToggleFlag(option,flag)
  exec ('let lopt = &' . a:option)
  if lopt =~ (".*" . a:flag . ".*")
    exec ('set ' . a:option . '-=' . a:flag)
  else
    exec ('set ' . a:option . '+=' . a:flag)
  endif
endfunction

map <silent> <F4> :call ToggleFlag("guioptions","m")<CR>
map <silent> <F5> :call ToggleFlag("guioptions","T")<CR>

" --- Comment -----------------
" ctrl+c, then c or x to comment/uncomment
au FileType sh,make let b:comment_leader = '# '
au FileType c,cpp,h,java,nut let b:comment_leader = '// '
au FileType vim let b:comment_leader = '" '
au FileType lua let b:comment_leader = '-- '
map <silent> <C-C>c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
map <silent> <C-C>x :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

" --- OmniCppComplete -----------------
let OmniCpp_NamespaceSearch = 1 
let OmniCpp_GlobalScopeSearch = 1 
let OmniCpp_ShowAccess = 1 
let OmniCpp_MayCompleteDot = 1 
let OmniCpp_MayCompleteArrow = 1 
let OmniCpp_MayCompleteScope = 1 
let OmniCpp_DefaultNamespaces = ["_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview


" Short mappings for common tasks
map ; :
" be able to scroll through opened files easily with ctrl+j/k
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
" Keep visual selection on indent
vmap > >gv
vmap < <gv
" For quick recordings just type qq to start recording, then q to stop.
" You don't have to worry about the name this way (you just named the recording 'q').
" Now, to play back the recording you just type Q. This will redefine the standard meaning of 'Q',
" but all that does is enter "Ex" mode which I can live without.
nnoremap Q @q
" To copy text to the end-of-line, you can press y$ or you can use the following and press Y instead. 
" This mapping sets up Y to be consistent with the C and D operators, which act from the cursor to the end of the line. 
" The default behavior of Y is to yank the whole line.
nnoremap Y y$

" toggle source/header
map <F12> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>


set guifont=ProggyCleanTTSZBP:h12

fun! SetColorscheme()
" 	colorscheme Twilight
" 	colorscheme rootwater
	"colorscheme Mustang2
	colorscheme xoria256
endfun
:call SetColorscheme()

