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

function! s:find_steps(start_lineno)    " {{{
    let current_lineno = a:start_lineno
    let current_level = foldlevel(a:start_lineno)
    let steps = []
    while current_level > 0
        let current_lineno = current_lineno - 1
        let new_level = foldlevel(current_lineno)
        if new_level < current_level
            call add(steps, current_lineno)
            let current_level = new_level
        endif
    endwhile
    return reverse(steps)
endfunction " }}}

function! breadcrumb#echomsg()  " {{{
    let start_lineno = line(".")
    let steps = s:find_steps(start_lineno)

    let i = 0
    while i < len(steps)
        echomsg breadcrumb#linetext(steps[i])
        echomsg breadcrumb#linetext(steps[i]+1)
        echomsg '...'
        let i = i + 1
    endwhile
    echomsg breadcrumb#linetext(start_lineno)
endfunction " }}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
