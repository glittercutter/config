" Version:      1.0
" Last Change:	January 1 2012

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

" Vim >= 7.0 specific colors
if version >= 700
    hi CursorLine   guibg=#2d2d2d
    hi CursorColumn guibg=#2d2d2d
    hi MatchParen   guifg=#d0ffc0 guibg=#2f2f2f gui=bold
    hi Pmenu 		guifg=#ffffff guibg=#444444
    hi PmenuSel 	guifg=#000000 guibg=#b1d631
endif

" Special cases
autocmd BufRead,BufNewFile * syn match Dmiter display '[{}()\[\];,]'
syn match Dmiter display '[{}()\[\];,]'
autocmd BufRead,BufNewFile * syn match Oper display '[-+*<>:!~&=|?\.\\]' | syn match Op display '[^/^*]/[^/^*]'
syn match Oper display '[-+*<>:!~&=|?\.\\]' | syn match Op display '[^/^\*]/[^/^\*]'

hi Dmiter       guifg=#00aa00
hi Oper         guifg=#00aaad

" General colors
hi Cursor 		guifg=NONE guibg=#00aaad
hi iCursor 		guifg=NONE guibg=#ff5552
hi Normal 		guifg=#adaaad guibg=#000000
hi NonText 		guifg=#adaaad guibg=NONE
hi LineNr 		guifg=#adaaad guibg=NONE
hi StatusLine 	guifg=#000000 guibg=#adaaad
hi StatusLineNC guifg=#000000 guibg=#000000
hi VertSplit 	guifg=#000000 guibg=#adaaad
" hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none ctermbg=4 ctermfg=248
hi Title		guifg=#00aa00 guibg=NONE
hi Visual		guifg=#000000 guibg=#00aaad
" hi SpecialKey	guifg=#808080 guibg=#343434 gui=none ctermfg=244 ctermbg=236

" Syntax highlighting
hi Comment 		guifg=#ff5552
hi Todo 		guifg=#00aa00
hi Boolean      guifg=#ffffff
hi String 		guifg=#00aa00
hi Identifier 	guifg=#ffffff gui=none
hi Function 	guifg=#adaaad
hi Type 		guifg=#ffffff gui=none
hi Statement 	guifg=#ffffff
hi Keyword		guifg=#ffffff
hi Constant 	guifg=#00aaad
hi Number		guifg=#5255ff
hi Special		guifg=#52ffff gui=none
hi PreProc 		guifg=#52ffff
hi Todo         guifg=#ff5552 guibg=#00aaad
hi Error        guifg=#ff55ff guibg=NONE

" Code-specific colors
hi pythonOperator guifg=#7e8aa2

hi Search       guifg=white	guibg=NONE

hi cIncluded    guifg=#5255ff guibg=NONE
hi cInclude     guifg=#52ffff guibg=NONE
