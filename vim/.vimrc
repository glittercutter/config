call pathogen#infect()
call pathogen#helptags()

" ================================
" Settings
" ================================

set nocompatible
set hlsearch
set scrolloff=3                 " Keep at least 3 lines above/below
set sidescrolloff=5             " Keep at least 5 lines left/right
set backspace=indent,eol,start  " Backspace over all kinds of things
set whichwrap+=<,>,h,l
set linebreak                   " Wrap at 'breakat' instead of last char
set undolevels=200
set updatecount=100             " Switch every 100 chars
set history=50                  " Command line history
set ttyfast
set magic
set noruler
set showcmd                     " Display incomplete commands
set incsearch
set number                      " Show line number
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

setlocal cinoptions={0,:1s,g1s,t0,(0,=.5s
setlocal cindent

" ================================
" Mapping
" ================================

map ; :

" Create new line above/below (opposite of Shift-J), overide open manpage.
nnoremap <S-J> o<Esc>k
nnoremap <S-K> O<Esc>j

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Switch window
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k

" Resize window
if bufwinnr(1)
    map <LEFT> <c-w><
    map <RIGHT> <c-w>>
    map <UP> <c-w>+
    map <DOWN> <c-w>-
endif

" Keep visual selection after indenting
vmap > >gv
vmap < <gv

" For quick recordings just type qq to start recording, then q to stop.
nnoremap Q @q

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Toggle src/header
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Sane indentation on pastes
set pastetoggle=<F10> 

" Quickfix
set errorfile="/tmp/quickfix.err"
"set errorformat+=%f:%l:\ %m     " For MinGW
nnoremap <F1> :cf /tmp/quickfix.err<CR>
nnoremap <F2> :cprev<CR>
nnoremap <F3> :cnext<CR>

" Tagbar
nmap <F11> :TagbarToggle<CR>
let g:tagbar_compact = 1
let g:tagbar_indent = 1

" ================================
" Plugins
" ================================

" NERDTree
let NERDTreeWinPos="right"
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

map <silent> <F12> :NERDTreeToggle<CR>

" powerline
set laststatus=2 " Always show the statusline
let g:Powerline_symbols = "compatible"

" ================================
" Misc
" ================================

" Use X11 clipboard
set clipboard=unnamed

" Autoreload config while editing
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Open those extensions as zip file.
au BufReadCmd *.odt,*.ott,*.ods,*.ots,*.odp,*.otp,*.odg,*.otg,*.xpi call zip#Browse(expand("<amatch>"))

" Syntax
au BufNewFile,BufRead *.cpp set syntax=cpp11
au BufRead,BufNewFile *.as set syntax=cpp "angelscript

colorscheme colorshot
"colorscheme classytouch

" Show attribute of text under the cursor (for colorscheme)
"map <F11> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


