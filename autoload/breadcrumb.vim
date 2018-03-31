" breadcrumb.vim
" Maintainer: NAGAMINE Hideaki

if exists('g:loaded_breadcrumb')
  finish
endif
let g:loaded_breadcrumb = 1

let s:save_cpo = &cpo
set cpo&vim
"
function! BreadcrumbGetOffset() " {{{
    if exists('b:breadcrumb_offset')
        return b:breadcrumb_offset
    endif
    if exists('g:breadcrumb_offset')
        return g:breadcrumb_offset
    endif
    return 0
endfunction " }}}

function! BreadcrumbGetContext()    " {{{
    if exists('b:breadcrumb_context')
        return b:breadcrumb_context
    endif
    if exists('g:breadcrumb_context')
        return g:breadcrumb_context
    endif
    return 2
endfunction " }}}

function! BreadcrumbLineText(lineno)    " {{{
    let level = foldlevel(a:lineno)
    let line = tr(getline(a:lineno), "\t", " ")
    return printf("%d(%d):%s", a:lineno, level, line)
endfunction " }}}

function! BreadcrumbEchoMsg()   " {{{
    let start_lineno = line(".")

    let current_lineno = start_lineno
    let current_level = foldlevel(start_lineno)
    let steps = []
    while current_level > 0
        let current_lineno = current_lineno - 1
        let new_level = foldlevel(current_lineno)
        if new_level < current_level
            call add(steps, current_lineno)
            let current_level = new_level
        endif
    endwhile

    let i = len(steps)-1
    while i >= 0
        echomsg BreadcrumbLineText(steps[i])
        echomsg BreadcrumbLineText(steps[i]+1)
        echomsg '...'
        let i = i - 1
    endwhile
    echomsg BreadcrumbLineText(start_lineno)
endfunction " }}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
