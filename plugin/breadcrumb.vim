scriptencoding utf-8

if exists('g:loaded_breadcrumb')
  finish
endif
let g:loaded_breadcrumb = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists(":BreadcrumbEchoMsg")
    command BreadcrumbEchoMsg :call breadcrumb#echomsg()
endif

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
