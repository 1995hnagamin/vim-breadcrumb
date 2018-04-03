" breadcrumb.vim
" Maintainer: NAGAMINE Hideaki

scriptencoding utf-8

if !exists('g:loaded_breadcrumb')
  finish
endif
let g:loaded_breadcrumb = 1

let s:save_cpo = &cpo
set cpo&vim
"
function! breadcrumb#offset()   " {{{
    if exists('b:breadcrumb_offset')
        return b:breadcrumb_offset
    endif
    if exists('g:breadcrumb_offset')
        return g:breadcrumb_offset
    endif
    return 0
endfunction " }}}

function! breadcrumb#context()  " {{{
    if exists('b:breadcrumb_context')
        return b:breadcrumb_context
    endif
    if exists('g:breadcrumb_context')
        return g:breadcrumb_context
    endif
    return 2
endfunction " }}}

function! breadcrumb#linetext(lineno)   " {{{
    let level = foldlevel(a:lineno)
    let line = tr(getline(a:lineno), "\t", " ")
    return printf("%d(%d):%s", a:lineno, level, line)
endfunction " }}}

function! s:find_steps(initial_lineno)    " {{{
    let lineno = a:initial_lineno
    let level = foldlevel(a:initial_lineno)
    let steps = []
    while level > 0
        let lineno = lineno - 1
        let new_level = foldlevel(lineno)
        if new_level < level
            call add(steps, lineno)
            let level = new_level
        endif
    endwhile
    return reverse(steps)
endfunction " }}}

function! s:does_include(hunk, lineno)  " {{{
    let [startpos, endpos] = a:hunk
    return startpos <= a:lineno && a:lineno <= endpos
endfunction "}}}

function! s:is_adjacent(hunk, lineno)   " {{{
    let [startpos, endpos] = a:hunk
    return (!s:does_include(a:hunk, a:lineno)) && a:lineno < endpos + 2
endfunction " }}}

function! s:hunks(steps, current_lineno)    " {{{
    call add(a:steps, a:current_lineno)
    let offset = breadcrumb#offset()
    let ctxt = breadcrumb#context()

    " [(startpos, endpos)]
    let hunks = [[a:steps[0]+offset, a:steps[0]+offset+ctxt-1]]
    for step in a:steps
        let lineno = step + offset
        if s:does_include(hunks[-1], lineno)
            continue
        elseif s:is_adjacent(hunks[-1], lineno)
            let new_hunk = [hunks[-1][0], lineno]
            let hunks[-1] = new_hunk
        else
            call add(hunks, [lineno, lineno+ctxt-1])
        endif
    endfor
    return hunks
endfunction " }}}

function! breadcrumb#echomsg()  " {{{
    let current_lineno = line(".")
    let steps = s:find_steps(current_lineno)

    let i = 0
    while i < len(steps)
        echomsg breadcrumb#linetext(steps[i])
        echomsg breadcrumb#linetext(steps[i]+1)
        echomsg '...'
        let i = i + 1
    endwhile
    echomsg breadcrumb#linetext(current_lineno)
endfunction " }}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
