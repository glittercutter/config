" Vim color file
" Maintainer:   glittercutter <.com>
" Last Change:  4 February 2012 - 0.2
" URL: glittercutter.github.com

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark "or light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="colorshot"

"if exists("g:transparent_background")
        hi Normal       ctermfg=7           ctermbg=none
        hi NonText      ctermfg=0           ctermbg=none
        hi Folded       ctermfg=7           ctermbg=none
        hi ErrorMsg     ctermfg=9           ctermbg=none cterm=bold term=bold
        hi WarningMsg   ctermfg=11          ctermbg=none
        hi VertSplit	ctermfg=0           ctermbg=none
        hi Directory    ctermfg=12          ctermbg=none
        hi Visual       ctermfg=none        ctermbg=8
        hi Title        ctermfg=7           ctermbg=none

        hi StatusLine   term=bold cterm=bold ctermfg=8 ctermbg=none
        hi StatusLineNC term=bold cterm=bold ctermfg=8 ctermbg=none
        hi LineNr       term=bold cterm=none ctermfg=1 ctermbg=none
        "hi LineNr       term=bold cterm=none ctermfg=8 ctermbg=none

        hi Statement    ctermfg=5           ctermbg=none
        hi Comment      ctermfg=4           ctermbg=none
        hi Constant     ctermfg=11           ctermbg=none
        hi Number       ctermfg=11           ctermbg=none
        "hi Constant     ctermfg=9           ctermbg=none
        "hi Number       ctermfg=9           ctermbg=none
        hi String       ctermfg=10          ctermbg=none
        hi Function     ctermfg=3           ctermbg=none
        hi Identifier   ctermfg=3           ctermbg=none cterm=none
        hi Operator     ctermfg=5           ctermbg=none
        hi Type         ctermfg=11          ctermbg=none
        hi Special      ctermfg=3           ctermbg=none
        hi PreProc      ctermfg=13          ctermbg=none
        hi Error        ctermfg=13          ctermbg=none
        hi Todo         ctermfg=13          ctermbg=none

        " C
        hi cCustomBlock  ctermfg=2          ctermbg=none
        hi cCustomCaller ctermfg=11         ctermbg=none

        hi IndentGuidesOdd  ctermbg=0
        hi IndentGuidesEven ctermbg=0

"else " Solid bg

        "hi Normal       ctermfg=LightGray ctermbg=Black
        "hi NonText      ctermfg=DarkGray  ctermbg=Black

        "hi Statement    ctermfg=Blue      ctermbg=Black
        "hi Comment      ctermfg=DarkGray  ctermbg=Black cterm=bold term=bold
        "hi Constant     ctermfg=DarkCyan  ctermbg=Black
        "hi Identifier   ctermfg=Cyan      ctermbg=Black
        "hi Type         ctermfg=DarkGreen ctermbg=Black
        "hi Folded       ctermfg=DarkGreen ctermbg=Black cterm=underline term=none
        "hi Special      ctermfg=Blue      ctermbg=Black
        "hi PreProc      ctermfg=LightGray ctermbg=Black cterm=bold term=bold
        "hi Scrollbar    ctermfg=Blue      ctermbg=Black
        "hi Cursor       ctermfg=white     ctermbg=Black
        "hi ErrorMsg     ctermfg=Red       ctermbg=Black cterm=bold term=bold
        "hi WarningMsg   ctermfg=Yellow    ctermbg=Black
        "hi VertSplit    ctermfg=White     ctermbg=Black
        "hi Directory    ctermfg=Cyan      ctermbg=DarkBlue
        "hi Visual       ctermfg=White     ctermbg=DarkGray cterm=underline term=none
        "hi Title        ctermfg=White     ctermbg=DarkBlue

        "hi StatusLine   term=bold cterm=bold,underline ctermfg=White ctermbg=Black
        "hi StatusLineNC term=bold cterm=bold,underline ctermfg=Gray  ctermbg=Black
        "hi LineNr       term=bold cterm=bold ctermfg=White ctermbg=DarkGray
"endif
