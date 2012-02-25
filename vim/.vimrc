call pathogen#infect()
call pathogen#helptags()

" *** Settings ***
set nocompatible
set hlsearch
set scrolloff=3                 " keep at least 3 lines above/below
set sidescrolloff=5             " keep at least 5 lines left/right
set backspace=indent,eol,start  " backspace over all kinds of things
set whichwrap+=<,>,h,l
set linebreak                   " wrap at 'breakat' instead of last char
set undolevels=200
set updatecount=100             " switch every 100 chars
set history=50                  " keep 50 lines of command line history
set ttyfast                     " we have a fast terminal
set magic                       " Enable the "magic"
set noruler
set showcmd                     " display incomplete commands
set incsearch                   " do incremental searching
set number                      " show line number
set lazyredraw                  " Don't redraw while executing macros 
set so=7                        " Set 7 lines to the curors - when moving vertical..
set wildmenu                    " Turn on WiLd menu
set cmdheight=1                 " The commandbar height
set hid                         " Change buffer - without saving
set showmatch                   " Show matching bracets when text indicator is over them
set noerrorbells
set novisualbell
set nobackup
set noswapfile
set tm=500
set t_Co=256
set smartcase
set smarttab
set expandtab                   " Tab to space
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set autoindent
set smartindent
set wrap                        " Wrap lines
set fillchars=vert:\            " Empty (space)

syntax on
filetype on                     " Enable filetype detection
filetype indent on              " Enable filetype-specific indenting
filetype plugin on              " Enable filetype-specific plugins


" *** NERDTree ***
let NERDTreeWinPos="right"
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
map <silent> <F12> :NERDTreeToggle<CR>

" *** Quickfix ***
set errorfile="../gcc.err"
set errorformat+=%f:%l:\ %m     " For MinGW
nnoremap <F1> :cf<CR>
nnoremap <F2> :cprev<CR>
nnoremap <F3> :cnext<CR>

" *** Mapping ***
map ; :

" Create new line above/below (opposite of Shift-J)
nnoremap <C-J> o<Esc>k
nnoremap <C-K> O<Esc>j

" Switch window
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" Resizing window with +/- keys (horizontal); / and * keys (vertical)
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

" Toggle src/header
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Tired of clearing highlighted searches by searching for ÅgldsfhjkhgakjksÅh? Use this:
nmap <silent> ,/ :nohlsearch<CR>

" Show attribute of text under the cursor (for colorscheme)
map <F11> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Copy/paste to X
"vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR><CR>
"nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
"imap <C-v> <Esc><C-v>a

" Spell check
map <F5> <Esc>:setlocal spell spelllang=fr<CR>
map <F6> <Esc>:setlocal spell spelllang=en_gb<CR>
map <F7> z=
map <F8> <Esc>:setlocal nospell<CR>

" *** Misc. ***
function Transparent()
    hi Normal ctermbg=none
endfunction

" Powerline
set laststatus=2 " Always show the statusline
let g:Powerline_symbols="unicode"

" vim-indent-guide plugin
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 3
let g:indent_guides_start_level = 2
"call IndentGuidesEnable

" C operator highlight
"if exists("*CSyntaxAfter")
    "call CSyntaxAfter()
"endif
"
" C++11
au BufNewFile,BufRead *.cpp set syntax=cpp11

colorscheme colorshot
"colorscheme zenburn
"call Transparent()
