" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
autoload/camelcasemotion.vim	[[[1
183
" camelcasemotion.vim: Motion through CamelCaseWords and underscore_notation. 
"
" DEPENDENCIES:
"   - Requires Vim 7.0 or higher. 
"
" Copyright: (C) 2007-2011 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'. 
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
" REVISION	DATE		REMARKS 
"   1.52.002	18-Oct-2011	FIX: Correct forward-to-end motion over
"				lowercase part in "lowerCamel". Found this by
"				chance in GitHub fork by Kevin Lee (bkad). 
"				BUG: Correct wrong stop on second letter of
"				ACRONYM at the beginning of a word "AXBCText". 
"   1.50.001	05-May-2009	Do not create mappings for select mode;
"				according to|Select-mode|, printable character
"				commands should delete the selection and insert
"				the typed characters. 
"				Moved functions from plugin to separate autoload
"				script. 
"   				file creation

"- functions ------------------------------------------------------------------"
function! s:Move( direction, count, mode )
    " Note: There is no inversion of the regular expression character class
    " 'keyword character' (\k). We need an inversion "non-keyword" defined as
    " "any non-whitespace character that is not a keyword character" (e.g.
    " [!@#$%^&*()]). This can be specified via a non-whitespace character in
    " whose place no keyword character matches (\k\@!\S). 

    "echo "count is " . a:count
    let l:i = 0
    while l:i < a:count
	if a:direction == 'e'
	    " "Forward to end" motion. 
	    "call search( '\>\|\(\a\|\d\)\+\ze_', 'We' )
	    " end of ...
	    " number | ACRONYM followed by CamelCase or number | lowercase followed by CamelCase, ACRONYM, or number | CamelCase | underscore_notation | non-keyword | word
	    " Note: Branches are ordered from specific to unspecific so that
	    " in case of multiple matches, the more specific (and usually
	    " longer) one it used. 
	    call search( '\d\+\|\u\+\ze\%(\u\l\|\d\)\|\l\+\ze\%(\u\|\d\)\|\u\l\+\|\%(\a\|\d\)\+\ze_\|\%(\k\@!\S\)\+\|\%(_\@!\k\)\+\>', 'We' )
	    " Note: word must be defined as '\k\>'; '\>' on its own somehow
	    " dominates over the previous branch. Plus, \k must exclude the
	    " underscore, or a trailing one will be incorrectly moved over:
	    " '\%(_\@!\k\)'. 
	    if a:mode == 'o'
		" Note: Special additional treatment for operator-pending mode
		" "forward to end" motion. 
		" The difference between normal mode, operator-pending and visual
		" mode is that in the latter two, the motion must go _past_ the
		" final "word" character, so that all characters of the "word" are
		" selected. This is done by appending a 'l' motion after the
		" search for the next "word". 
		"
		" In operator-pending mode, the 'l' motion only works properly
		" at the end of the line (i.e. when the moved-over "word" is at
		" the end of the line) when the 'l' motion is allowed to move
		" over to the next line. Thus, the 'l' motion is added
		" temporarily to the global 'whichwrap' setting. 
		" Without this, the motion would leave out the last character in
		" the line. I've also experimented with temporarily setting
		" "set virtualedit=onemore" , but that didn't work. 
		let l:save_ww = &whichwrap
		set whichwrap+=l
		normal! l
		let &whichwrap = l:save_ww
	    endif
	else
	    " Forward (a:direction == '') and backward (a:direction == 'b')
	    " motion. 

	    let l:direction = (a:direction == 'w' ? '' : a:direction)

	    " CamelCase: Jump to beginning of either (start of word, Word, WORD,
	    " 123). 
	    " Underscore_notation: Jump to the beginning of an underscore-separated
	    " word or number. 
	    "call search( '\<\|\u', 'W' . l:direction )
	    "call search( '\<\|\u\(\l\+\|\u\+\ze\u\)\|\d\+', 'W' . l:direction )
	    "call search( '\<\|\u\(\l\+\|\u\+\ze\u\)\|\d\+\|_\zs\(\a\|\d\)\+', 'W' . l:direction )
	    " beginning of ...
	    " word | empty line | non-keyword after whitespaces | non-whitespace after word | number | start of ACRONYM followed by CamelCase or number | CamelCase | underscore followed by ACRONYM, Camel, lowercase or number
	    " Note: Branches are ordered from unspecific to specific, so that
	    " the cursor moves the least amount of text. 
	    call search( '\<\D\|^$\|\%(^\|\s\)\+\zs\k\@!\S\|\>\S\|\d\+\|\u\@<!\u\+\ze\%(\u\l\|\d\)\|\u\l\+\|_\zs\%(\u\+\|\u\l\+\|\l\+\|\d\+\)', 'W' . l:direction )
	    " Note: word must be defined as '\<\D' to avoid that a word like
	    " 1234Test is moved over as [1][2]34[T]est instead of [1]234[T]est
	    " because \< matches with zero width, and \d\+ will then start
	    " matching '234'. To fix that, we make \d\+ be solely responsible
	    " for numbers by taken this away from \< via \<\D. (An alternative
	    " would be to replace \d\+ with \D\%#\zs\d\+, but that one is more
	    " complex.) All other branches are not affected, because they match
	    " multiple characters and not the same character multiple times. 
	endif
	let l:i = l:i + 1
    endwhile
endfunction

function! camelcasemotion#Motion( direction, count, mode )
"*******************************************************************************
"* PURPOSE:
"   Perform the motion over CamelCaseWords or underscore_notation. 
"* ASSUMPTIONS / PRECONDITIONS:
"   none
"* EFFECTS / POSTCONDITIONS:
"   Move cursor / change selection. 
"* INPUTS:
"   a:direction	one of 'w', 'b', 'e'
"   a:count	number of "words" to move over
"   a:mode	one of 'n', 'o', 'v', 'iv' (latter one is a special visual mode
"		when inside the inner "word" text objects. 
"* RETURN VALUES: 
"   none
"*******************************************************************************
    " Visual mode needs special preparations and postprocessing; 
    " normal and operator-pending mode breeze through to s:Move(). 

    if a:mode == 'v'
	" Visual mode was left when calling this function. Reselecting the current
	" selection returns to visual mode and allows to call search() and issue
	" normal mode motions while staying in visual mode. 
	normal! gv
    endif
    if a:mode == 'v' || a:mode == 'iv'

	" Note_1a:
	if &selection != 'exclusive' && a:direction == 'w'
	    normal! l
	endif
    endif

    call s:Move( a:direction, a:count, a:mode )

    if a:mode == 'v' || a:mode == 'iv'
	" Note: 'selection' setting. 
	if &selection == 'exclusive' && a:direction == 'e'
	    " When set to 'exclusive', the "forward to end" motion (',e') does not
	    " include the last character of the moved-over "word". To include that, an
	    " additional 'l' motion is appended to the motion; similar to the
	    " special treatment in operator-pending mode. 
	    normal! l
	elseif &selection != 'exclusive' && a:direction != 'e'
	    " Note_1b:
	    " The forward and backward motions move to the beginning of the next "word".
	    " When 'selection' is set to 'inclusive' or 'old', this is one character too far. 
	    " The appended 'h' motion undoes this. Because of this backward step,
	    " though, the forward motion finds the current "word" again, and would
	    " be stuck on the current "word". An 'l' motion before the CamelCase
	    " motion (see Note_1a) fixes that. 
	    normal! h
	endif
    endif
endfunction

function! camelcasemotion#InnerMotion( direction, count )
    " If the cursor is positioned on the first character of a CamelWord, the
    " backward motion would move to the previous word, which would result in a
    " wrong selection. To fix this, first move the cursor to the right, so that
    " the backward motion definitely will cover the current "word" under the
    " cursor. 
    normal! l
    
    " Move "word" backwards, enter visual mode, then move "word" forward. This
    " selects the inner "word" in visual mode; the operator-pending mode takes
    " this selection as the area covered by the motion. 
    if a:direction == 'b'
	" Do not do the selection backwards, because the backwards "word" motion
	" in visual mode + selection=inclusive has an off-by-one error. 
	call camelcasemotion#Motion( 'b', a:count, 'n' )
	normal! v
	" We decree that 'b' is the opposite of 'e', not 'w'. This makes more
	" sense at the end of a line and for underscore_notation. 
	call camelcasemotion#Motion( 'e', a:count, 'iv' )
    else
	call camelcasemotion#Motion( 'b', 1, 'n' )
	normal! v
	call camelcasemotion#Motion( a:direction, a:count, 'iv' )
    endif
endfunction

" vim: set sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
plugin/camelcasemotion.vim	[[[1
207
" camelcasemotion.vim: Motion through CamelCaseWords and underscore_notation. 
"
" DEPENDENCIES:
"   - Requires Vim 7.0 or higher. 
"   - camelcasemotion.vim autoload script. 
"
" Copyright: (C) 2007-2011 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'. 
"
" Source: Based on vimtip #1016 by Anthony Van Ham. 
" Maintainer:	Ingo Karkat <ingo@karkat.de>
" REVISION	DATE		REMARKS 
"   1.51.020	30-Sep-2011	Use <silent> for <Plug> mapping instead of
"				default mapping. 
"   1.50.019	05-May-2009	Do not create mappings for select mode;
"				according to|Select-mode|, printable character
"				commands should delete the selection and insert
"				the typed characters. 
"   				Moved functions from plugin to separate autoload
"				script. 
"   				Split off documentation into separate help file. 
"   				Now cleaning up Create...Mappings functions. 
"   1.40.018	30-Jun-2008	Minor: Removed unnecessary <script> from
"				mappings. 
"   1.40.017	19-May-2008	BF: Now using :normal! to be independent from
"				any user mappings. Thanks to Neil Walker for the
"				patch. 
"   1.40.016	28-Apr-2008	BF: Wrong forward motion stop at the second
"				digit if a word starts with multiple numbers
"				(e.g. 1234.56789). Thanks to Wasim Ahmed for
"				reporting this. 
"   1.40.015	24-Apr-2008	ENH: Added inner "word" text objects 'i,w' etc.
"				that work analogous to the built-in 'iw' text
"				object. Thanks to David Kotchan for this
"				suggestion. 
"   1.30.014	20-Apr-2008	The motions now also stop at non-keyword
"				boundaries, just like the regular motions. This
"				has no effect inside a CamelCaseWord or inside
"				underscore_notation, but it makes the motions
"				behave like the regular motions (which is
"				important if you replace the default motions). 
"				Thanks to Mun Johl for reporting this. 
"				Now using non-capturing parentheses \%() in the
"				patterns. 
"   1.30.013	09-Apr-2008	Refactored away s:VisualCamelCaseMotion(). 
"				Allowing users to use mappings different than
"				,w ,b ,e by defining <Plug>CamelCaseMotion_?
"				target mappings. This can even be used to
"				replace the default 'w', 'b' and 'e' mappings,
"				as suggested by Mun Johl. 
"				Mappings are now created in a generic function. 
"				Now requires Vim 7.0 or higher. 
"   1.20.012	02-Jun-2007	BF: Corrected motions through mixed
"				CamelCase_and_UnderScore words by re-ordering
"				and narrowing the search patterns.  
"   1.20.011	02-Jun-2007	Thanks again to Joseph Barker for discussing the
"				complicated visual mode mapping on the vim-dev
"				mailing list and coming up with a great
"				simplification:
"				Removed s:CheckForChangesToTheSelectionSetting().
"				Introduced s:VisualCamelCaseMotion(), which
"				handles the differences depending on the
"				'selection' setting. 
"				Visual mode mappings now directly map to the
"				s:VisualCamelCaseMotion() function; no mark is
"				clobbered, the complex mapping with the inline
"				expression has been retired. 
"   1.20.010	29-May-2007	BF: The operator-pending and visual mode ,e
"				mapping doesn't work properly when it reaches
"				the end of line; the final character of the
"				moved-over "word" remains. Fixed this problem
"				unless the "word" is at the very end of the
"				buffer. 
"				ENH: The visual mode motions now also (mostly)
"				work with the (default) setting
"				'set selection=inclusive', instead of selecting
"				one character too much. 
"				ENH: All mappings will check for changes to the
"				'selection' setting and remap the visual mode
"				mappings via function
"				s:SetupVisualModeMappings(). We cannot rely on
"				the setting while sourcing camelcasemotion.vim
"				because the mswin.vim script may be sourced
"				afterwards, and its 'behave mswin' changes
"				'selection'. 
"				Refactored the arguments of function 
"				s:CamelCaseMotion(...). 
"   1.10.009	28-May-2007	BF: Degenerate CamelCaseWords that consist of
"				only a single uppercase letter (e.g. "P" in
"				"MapPRoblem") are skipped by all motions. Thanks
"				to Joseph Barker for reporting this. 
"				BF: In CamelCaseWords that consist of uppercase
"				letters followed by decimals (e.g.
"				"MyUPPER123Problem", the uppercase "word" is
"				skipped by all motions. 
"   1.10.008	28-May-2007	Incorporated major improvements and
"				simplifications done by Joseph Barker:
"				Operator-pending and visual mode motions now
"				accept [count] of more than 9. 
"				Visual selections can now be extended from
"				either end. 
"				Instead of misusing the :[range], the special
"				variable v:count1 is used. Custom commands are
"				not needed anymore. 
"				Operator-pending and visual mode mappings are
"				now generic: There's only a single mapping for
"				,w that can be repeated, rather than having a
"				separate mapping for 1,w 2,w 3,w ...
"   1.00.007	22-May-2007	Added documentation for publication. 
"	006	20-May-2007	BF: visual mode [1,2,3],e on pure CamelCase
"				mistakenly marks [2,4,6] words. If the cursor is
"				on a uppercase letter, the search pattern
"				'\u\l\+' doesn't match at the cursor position,
"				so another match won. Changed search pattern
"				from '\l\+', 
"	005	16-May-2007	Added support for underscore notation. 
"				Added support for "forward to end of word"
"				(',e') motion. 
"	004	16-May-2007	Improved search pattern so that
"				UppercaseWORDSInBetween and digits are handled,
"				too. 
"	003	15-May-2007	Changed mappings from <Leader>w to ,w; 
"				other \w mappings interfere here, because it's
"				irritating when the cursor jump doesn't happen
"				immediately, because Vim waits whether the
"				mapping is complete. ,w is faster to type that
"				\w (and, because of the left-right touch,
"				preferred over gw). 
"				Added visual mode mappings. 
"	0.02	15-Feb-2006	BF: missing <SID> for omaps. 
"	0.01	11-Oct-2005	file creation

" Avoid installing twice or when in compatible mode
if exists('g:loaded_camelcasemotion') || (v:version < 700)
    finish
endif
let g:loaded_camelcasemotion = 1

"- mappings -------------------------------------------------------------------
" The count is passed into the function through the special variable 'v:count1',
" which is easier than misusing the :[range] that :call supports. 
" <C-U> is used to delete the unused range. 
" Another option would be to use a custom 'command! -count=1', but that doesn't
" work with the normal mode mapping: When a count is typed before the mapping,
" the ':' will convert a count of 3 into ':.,+2MyCommand', but ':3MyCommand'
" would be required to use -count and <count>. 
"
" We do not provide the fourth "backward to end" motion (,E), because it is
" seldomly used. 

function! s:CreateMotionMappings()
    " Create mappings according to this template:
    " (* stands for the mode [nov], ? for the underlying motion [wbe].) 
    "
    " *noremap <silent> <Plug>CamelCaseMotion_? :<C-U>call camelcasemotion#Motion('?',v:count1,'*')<CR>
    " if ! hasmapto('<Plug>CamelCaseMotion_?', '*')
    "	  *map ,? <Plug>CamelCaseMotion_?
    " endif

    for l:mode in ['n', 'o', 'v']
	for l:motion in ['w', 'b', 'e']
	    let l:targetMapping = '<Plug>CamelCaseMotion_' . l:motion
	    execute l:mode . 'noremap <silent> ' . l:targetMapping . ' :<C-U>call camelcasemotion#Motion(''' . l:motion . ''',v:count1,''' . l:mode . ''')<CR>'
	    if ! hasmapto(l:targetMapping, l:mode)
		execute (l:mode ==# 'v' ? 'x' : l:mode) . 'map ,' . l:motion . ' ' . l:targetMapping 
	    endif
	endfor
    endfor
endfunction

" To create a text motion, a mapping for operator-pending mode needs to be
" defined. This mapping should move the cursor according to the implemented
" motion, or mark the covered text via a visual selection. As inner text motions
" need to mark both to the left and right of the cursor position, the visual
" selection needs to be used. 
"
" Vim's built-in inner text objects also work in visual mode; they have
" different behavior depending on whether visual mode has just been entered or
" whether text has already been selected. 
" We deviate from that and always override the existing selection. 
function! s:CreateInnerMotionMappings()
    " Create mappings according to this template:
    " (* stands for the mode [ov], ? for the underlying motion [wbe].) 
    "
    " *noremap <silent> <Plug>CamelCaseMotion_i? :<C-U>call camelcasemotion#InnerMotion('?',v:count1)<CR>
    " if ! hasmapto('<Plug>CamelCaseInnerMotion_i?', '*')
    "	  *map i,? <Plug>CamelCaseInnerMotion_i?
    " endif

    for l:mode in ['o', 'v']
	for l:motion in ['w', 'b', 'e']
	    let l:targetMapping = '<Plug>CamelCaseMotion_i' . l:motion
	    execute l:mode . 'noremap <silent> ' . l:targetMapping . ' :<C-U>call camelcasemotion#InnerMotion(''' . l:motion . ''',v:count1)<CR>'
	    if ! hasmapto(l:targetMapping, l:mode)
		execute (l:mode ==# 'v' ? 'x' : l:mode) . 'map i,' . l:motion . ' ' . l:targetMapping 
	    endif
	endfor
    endfor
endfunction

call s:CreateMotionMappings()
call s:CreateInnerMotionMappings()

delfunction s:CreateMotionMappings
delfunction s:CreateInnerMotionMappings

" vim: set sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
doc/camelcasemotion.txt	[[[1
220
*camelcasemotion.txt*   Motion through CamelCaseWords and underscore_notation. 

		     CAMEL CASE MOTION    by Ingo Karkat
							 *camelcasemotion.vim*
description			|camelcasemotion-description|
usage				|camelcasemotion-usage|
installation			|camelcasemotion-installation|
configuration			|camelcasemotion-configuration|
known problems			|camelcasemotion-known-problems|
todo				|camelcasemotion-todo|
history				|camelcasemotion-history|

==============================================================================
DESCRIPTION					 *camelcasemotion-description*

Vim provides many built-in motions, e.g. to move to the next word, or end of
the current word. Most programming languages use either CamelCase
("anIdentifier") or underscore_notation ("an_identifier") naming conventions
for identifiers. The best way to navigate inside those identifiers using Vim
built-in motions is the [count]f{char} motion, i.e. f{uppercase-char} or f_,
respectively. But we can make this easier: 

This plugin defines motions |,w| |,b| and |,e| (similar to |w| |b| |e|), which do
not move word-wise (forward/backward), but Camel-wise; i.e. to word boundaries
and uppercase letters. The motions also work on underscore notation, where
words are delimited by underscore ('_') characters. From here on, both
CamelCase and underscore_notation entities are referred to as "words" (in
double quotes). Just like with the regular motions, a [count] can be prepended
to move over multiple "words" at once. Outside of "words" (e.g. in non-keyword
characters like // or ;), the new motions move just like the regular motions. 

Vim provides a built-in |iw| text object called 'inner word', which works in
operator-pending and visual mode. Analog to that, this plugin defines inner
"word" motions |i,w| |i,b| and |i,e|, which select the "word" (or multiple
"words" if a [count] is given) where the cursor is located. 

==============================================================================
USAGE						       *camelcasemotion-usage*
								*,w* *,b* *,e*
Use the new motions |,w| |,b| and |,e| in normal mode, operator-pending mode
(cp. |operator|), and visual mode. For example, type bc,w to change "Camel"
in "CamelCase" to something else. 


EXAMPLE: motions
Given the following CamelCase identifiers in a source code fragment:
    set Script31337PathAndNameWithoutExtension11=%~dpn0 ~
    set Script31337PathANDNameWITHOUTExtension11=%~dpn0 ~
and the corresponding identifiers in underscore_notation:
    set script_31337_path_and_name_without_extension_11=%~dpn0 ~
    set SCRIPT_31337_PATH_AND_NAME_WITHOUT_EXTENSION_11=%~dpn0 ~

,w moves to ([x] is cursor position): [s]et, [s]cript, [3]1337, [p]ath,
    [a]nd, [n]ame, [w]ithout, [e]xtension, [1]1, [d]pn0, dpn[0], [s]et
,b moves to: [d]pn0, [1]1, [e]xtension, [w]ithout, ...
,e moves to: se[t], scrip[t], 3133[7], pat[h], an[d], nam[e], withou[t],
    extensio[n], 1[1], dpn[0]


EXAMPLE: inner motions
Given the following identifier, with the cursor positioned at [x]:
    script_31337_path_and_na[m]e_without_extension_11 ~

v3i,w selects script_31337_path_and_[name_without_extension_]11
v3i,b selects script_31337_[path_and_name]_without_extension_11
v3i,e selects script_31337_path_and_[name_without_extension]_11
Instead of visual mode, you can also use c3i,w to change, d3i,w to delete,
gU3i,w to upper-case, and so on. 

==============================================================================
INSTALLATION					*camelcasemotion-installation*

This script is packaged as a |vimball|. If you have the "gunzip" decompressor
in your PATH, simply edit the *.vba.gz package in Vim; otherwise, decompress
the archive first, e.g. using WinZip. Inside Vim, install by sourcing the
vimball or via the |:UseVimball| command. >
    vim camelcasemotion.vba.gz
    :so %
To uninstall, use the |:RmVimball| command. 

DEPENDENCIES					*camelcasemotion-dependencies*

- Requires Vim 7.0 or higher. 

==============================================================================
CONFIGURATION				       *camelcasemotion-configuration*

By default, all mappings start with |,| (comma) as the map leader instead of
using <Leader>. I personally find the default <Leader> key too far off the
keyboard to be useful for custom motions (which also cannot be repeated via
the |.| (dot) command, so they should be very fast to type repeatedly), but
quite suitable for general, less frequently used custom mappings. 
To avoid losing the (rarely used) |,| mapping (which repeats latest f, t, F or
T in opposite direction), you can remap it to ,,: >
    nnoremap ,, ,
    xnoremap ,, ,
    onoremap ,, ,

If you want to use different mappings, map your keys to the
<Plug>CamelCaseMotion_? mapping targets _before_ sourcing this script (e.g. in
your |vimrc|).  

EXAMPLE: Replace the default |w|, |b| and |e| mappings instead of defining
additional mappings |,w|, |,b|  and |,e| : >
    map w <Plug>CamelCaseMotion_w
    map b <Plug>CamelCaseMotion_b
    map e <Plug>CamelCaseMotion_e
    sunmap w
    sunmap b
    sunmap e

EXAMPLE: Replace default |iw| text-object and define |ib| and  |ie| motions: >
    omap iw <Plug>CamelCaseMotion_iw
    xmap iw <Plug>CamelCaseMotion_iw
    omap ib <Plug>CamelCaseMotion_ib
    xmap ib <Plug>CamelCaseMotion_ib
    omap ie <Plug>CamelCaseMotion_ie
    xmap ie <Plug>CamelCaseMotion_ie

==============================================================================
KNOWN PROBLEMS				      *camelcasemotion-known-problems*

- A degenerate CamelCaseWord containing '\U\u\d' (e.g. "MaP1Roblem") confuses
  the operator-pending and visual mode ,e mapping if 'selection' is not set to
  "exclusive". It'll skip "P" and select "P1" in one step. As a workaround,
  use ',w' instead of ',e'; those two mappings have the same effect inside
  CamelCaseWords, anyway. 
- The operator-pending and visual mode ,e mapping doesn't work properly when
  it reaches the end of the buffer; the final character of the moved-over
  "word" remains, and a beep is issued. As a workaround, use the default 'e'
  motion instead of ',e'. 
- When the Vim setting 'selection' is not set to "exclusive", a
  forward-backward combination in visual mode (e.g. 'v,w,b') selects one
  additional character to the left, instead of only the character where the
  motion started. Likewise, extension of the visual selection from the front
  end is off by one additional character. 

==============================================================================
TODO							*camelcasemotion-todo*

IDEAS						       *camelcasemotion-ideas*

- Use search('\%#.\%$', 'cnW') to detect the operator-pending motion to the
  end of the buffer and temporarily append a new line / space character to
  work around the end-of-buffer problem. Unfortunately, the addition cannot be
  undone as part of the motion (won't work then), so we'd have to use an
  autocmd to remove it later. 

- Make separator character (currently underscore) configurable so that dashes,
  asterisks, etc. can be added as well. Idea is to replace the single /_/ with
  a collection /[-_*]/ built from g:CamelCaseMotion_SeparatorCharacters. Check
  out interference with containment in 'iskeyword' and think through need to
  buffer-local setting. (Submitted anonymously 13-Nov-2010 on Vim Tips Wiki.) 

==============================================================================
HISTORY						     *camelcasemotion-history*

1.52	12-Nov-2011
- FIX: Correct forward-to-end motion over lowercase part in "lowerCamel".
  Found this by chance in GitHub fork by Kevin Lee (bkad). 
- BUG: Correct wrong stop on second letter of ACRONYM at the beginning of a
  word "AXBCText". 
- The motion functionality is automatically tested via a runVimTests
  (vimscript #2565) test suite. 

1.51	30-Sep-2011
Use <silent> for <Plug> mapping instead of default mapping. 

1.50	05-May-2009
- Do not create mappings for select mode; according to |Select-mode|,
  printable character commands should delete the selection and insert the
  typed characters. Now using :xmap to only target visual mode. 
- Moved functions from plugin to separate autoload script. 
- Split off documentation into separate help file. Now packaging as VimBall. 

1.40	30-Jun-2008
BF: Now using :normal! to be independent from any user mappings. Thanks to
Neil Walker for the patch.

1.40	19-May-2008
BF: Wrong forward motion stop at the second digit if a word starts with
multiple numbers (e.g. 1234.56789). Thanks to Wasim Ahmed for reporting this.

1.40	24-Apr-2008
ENH: Added inner "word" text objects 'i,w' etc. that work analoguous to the
built-in |iw| text object. Thanks to David Kotchan for this suggestion.

1.30	20-Apr-2008
The motions now also stop at non-keyword boundaries, just like the regular
motions. This has no effect inside a CamelCaseWord or inside
underscore_notation, but it makes the motions behave like the regular motions
(which is important if you replace the default motions). Thanks to Mun Johl
for reporting this. 

1.30	09-Apr-2008
- Allowing users to use mappings different than ,w ,b ,e by defining
  <Plug>CamelCaseMotion_? target mappings. This can even be used to replace
  the default 'w', 'b' and 'e' mappings, as suggested by Mun Johl.
- Now requires VIM 7.0 or higher. 

1.20	29-May-2007
ENH: The visual mode motions now also (mostly) work with the (default) setting
'set selection=inclusive', instead of selecting one character too much. 

1.10	28-May-2007
Incorporated major improvements and simplifications done by Joseph Barker. 

1.00	22-May-2007
First published version. 

0.01	11-Oct-2005
Started development based on vimtip #1016 by Anthony Van Ham. 

==============================================================================
Copyright: (C) 2007-2011 Ingo Karkat
The VIM LICENSE applies to this script; see |copyright|. 

Maintainer:	Ingo Karkat <ingo@karkat.de>
==============================================================================
 vim:tw=78:ts=8:ft=help:norl:
