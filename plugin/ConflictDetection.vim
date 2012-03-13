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

"- configuration ---------------------------------------------------------------

if ! exists('g:ConflictDetection_AutoDetectEvents')
    let g:ConflictDetection_AutoDetectEvents = 'BufReadPost,BufWritePre'
endif
if ! exists('g:ConflictDetection_WarnEvents')
    let g:ConflictDetection_WarnEvents = 'BufReadPost,BufWritePost'
endif


"- functions -------------------------------------------------------------------

function! s:ConflictCheck()
    let b:conflicted = !! search('^\([<=>|]\)\{7}\1\@!', 'cnw')
endfunction
function! s:ConflictWarn()
    if ! exists('b:conflicted')
	call s:ConflictCheck()
    endif

    if b:conflicted
	let v:warningmsg = 'Conflict markers found'
	echohl WarningMsg
	echomsg v:warningmsg
	echohl None
    endif
endfunction
function! s:ConflictHighlight()
    if ! exists('b:conflicted')
	call s:ConflictCheck()
    endif

    if b:conflicted
	call ConflictDetection#Highlight()
    endif
endfunction


"- autocmds --------------------------------------------------------------------

augroup ConflictDetection
    autocmd!
    if ! empty(g:ConflictDetection_AutoDetectEvents)
	execute 'autocmd' g:ConflictDetection_AutoDetectEvents '* call <SID>ConflictCheck()'
    endif
    if ! empty(g:ConflictDetection_WarnEvents)
	execute 'autocmd' g:ConflictDetection_WarnEvents '* call <SID>ConflictWarn()'
    endif

    autocmd BufReadPost,FileType * call <SID>ConflictHighlight()
augroup END


"- highlight groups ------------------------------------------------------------

highlight def link conflictOurs  DiffAdd
highlight def link conflictBase  DiffChange
highlight def link conflictTheirs DiffText
highlight def link conflictSeparatorMarkerSymbol    NonText
highlight def conflictOursMarker        gui=none guifg=#bada9f
highlight def conflictBaseMarker        gui=none guifg=#e5d5ac
highlight def conflictSeparatorMarker   gui=none guifg=#a0a0a0
highlight def conflictTheirsMarker      gui=none guifg=#8cbee2

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
