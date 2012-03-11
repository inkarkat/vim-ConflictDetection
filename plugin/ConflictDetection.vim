" ConflictDetection.vim: summary
"
" DEPENDENCIES:
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	12-Mar-2012	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_ConflictDetection') || (v:version < 700)
    finish
endif
let g:loaded_ConflictDetection = 1

function! HighlightConflicts()
    syntax region conflictOurs   matchgroup=conflictOursMarker start="^<\{7}<\@!.*$"   end="^\([=|]\)\{7}\1\@!"me=s-1 keepend containedin=TOP
    syntax region conflictBase   matchgroup=conflictBaseMarker start="^|\{7}|\@!.*$"   end="^=\{7}=\@!"me=s-1         keepend containedin=TOP
    syntax region conflictTheirs start="^=\{7}=\@!.*$" matchgroup=conflictTheirsMarker end="^>\{7}>\@!.*$"            keepend containedin=TOP contains=conflictSeparatorMarkerSymbol

    syntax match conflictOursMarkerSymbol       "^<\{7}"        contained
    syntax match conflictBaseMarkerSymbol       "^|\{7}"        contained
    syntax match conflictSeparatorMarkerSymbol  "^=\{7}"        contained
    syntax match conflictTheirsMarkerSymbol     "^>\{7}"        contained
endfunction

highlight def link conflictOurs  DiffAdd
highlight def link conflictBase  DiffChange
highlight def link conflictTheirs DiffText
highlight def link conflictSeparatorMarkerSymbol    NonText
highlight def conflictOursMarker        gui=none guifg=#bada9f
highlight def conflictBaseMarker        gui=none guifg=#e5d5ac
highlight def conflictSeparatorMarker   gui=none guifg=#a0a0a0
highlight def conflictTheirsMarker      gui=none guifg=#8cbee2

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
