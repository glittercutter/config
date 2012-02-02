set nocompatible

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

function ToggleFlag(option, flag)
  exec ('let lopt = &' . a:option)
  if lopt =~ (".*" . a:flag . ".*")
    exec ('set ' . a:option . '-=' . a:flag)
  else
    exec ('set ' . a:option . '+=' . a:flag)
  endif
endfun

" => Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=3                 " keep at least 3 lines above/below
set sidescrolloff=5             " keep at least 5 lines left/right
set backspace=indent,eol,start  " backspace over all kinds of things
set whichwrap+=<,>,h,l
set noerrorbells                " no error bells please
set linebreak                   " wrap at 'breakat' instead of last char
set undolevels=200
set updatecount=100             " switch every 100 chars
set ttyfast                     " we have a fast terminal
set magic                       " Enable the "magic"
set cursorline                  " show the cursor line
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set incsearch                   " do incremental searching
set number                      " show line number
set clipboard=unnamed
set nobackup
set noswapfile
set lazyredraw                  " Don't redraw while executing macros 
set so=7                        " Set 7 lines to the curors - when moving vertical..
set wildmenu                    " Turn on WiLd menu
set cmdheight=1                 " The commandbar height
set hid                         " Change buffer - without saving
set smartcase
set showmatch                   " Show matching bracets when text indicator is over them
set mat=1                       " How many tenths of a second to blink
set noerrorbells
set novisualbell
set t_vb=
set tm=500
"set colorcolumn=80              " Color the n'th column
filetype on                     " Enable filetype detection
filetype indent on              " Enable filetype-specific indenting
filetype plugin on              " Enable filetype-specific plugins

" => GUI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions-=T               " Remove bar
set guioptions-=b               " 
set guioptions-=m               " 
set guioptions-=l               " Remove scrollbar
set guioptions-=L               " 
set guioptions-=r               " 
set guioptions-=b               " 

function Menu() " Toggle menu bar
    call ToggleFlag("guioptions","m")<CR>
endfun

" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab                   " convert tab to space
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai                          "Auto indent
set si                          "Smart indet
set wrap                        "Wrap lines

" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeWinPos="right"
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
map <silent> <F12> :NERDTreeToggle<CR>

" => Quickfix
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set errorfile="../gcc.err"
set errorformat+=%f:%l:\ %m " for MinGW
nnoremap <F1> :cf<CR>
nnoremap <F2> :cprev<CR>
nnoremap <F3> :cnext<CR>

" => Mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map ; :

" Ctrl-P toggles paste mode (disable autoindent, etc...)
"set pastetoggle=<C-P>

" create new line above/below (opposite of Shift-J)
nnoremap <C-J> o<Esc>k
nnoremap <C-K> O<Esc>j

" Fast window switching
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" Fast window resizing with +/- keys (horizontal); / and * keys (vertical)
if bufwinnr(1)
    map <kplus> <c-w>+
    map <kminus> <c-w>-
    map <kdivide> <c-w><
    map <kmultiply> <c-w>>
endif

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
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Tired of clearing highlighted searches by searching for ÅgldsfhjkhgakjksÅh? Use this:
nmap <silent> ,/ :nohlsearch<CR>

" show attribute of text under the cursor (for colorscheme)
map <F11> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guifont=Dina:h9
colorscheme zenburn
hi Normal ctermbg=none
hi ColorColumn ctermbg=238
