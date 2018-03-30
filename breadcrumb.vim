function! BCline(lineno)
    let level = foldlevel(a:lineno)
    let line = tr(getline(a:lineno), "\t", " ")
    return printf("%d(%d):%s", a:lineno, level, line)
endfunction

function! BCecho()
    let start_line = line(".")
    let start_level = foldlevel(start_line)

    let current_line = start_line
    let current_level = start_level
    let steps = []
    while current_level > 0
        let current_line = current_line - 1
        let new_level = foldlevel(current_line)
        " echomsg string([current_line, new_level, getline(current_line)])
        if new_level < current_level
            call add(steps, current_line+1)
            let current_level = new_level
        endif
    endwhile

    let i = len(steps)-1
    while i >= 0
        echomsg BCline(steps[i])
        echomsg BCline(steps[i]+1)
        echomsg '...'
        let i = i - 1
    endwhile
endfunction
