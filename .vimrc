" Modelline {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=10 foldmethod=marker spell:
" }

" Detect OS {
    let s:is_unix = has('unix')
    let s:is_windows = has('win16') || has('win32') || has('win64')
    let s:is_cygwin = has('win32unix')
    let s:is_macvim = has('gui_macvim')
" }

function! IsWindows()
    return s:is_windows
endfunction

function! IsUnix()
    return s:is_unix
endfunction

function! IsCygWin()
    return s:is_cygwin
endfunction

function! IsMac()
    return s:is_macvim
endfunction

let s:m_w = 1 + getpid()
let s:m_z = localtime()

function! RandomNumber(...)
    if a:0 == 0
        let s:m_z = (36969 * and(s:m_z, 0xffff)) + (s:m_z / 65536)
        let s:m_w = (18000 * and(s:m_w, 0xffff)) + (s:m_w / 65536)
        return (s:m_z * 65536) + s:m_w      " 32-bit result
    elseif a:0 == 1 " We return a number in [0, a:1] or [a:1, 0]
        return a:1 < 0 ? RandomNumber(a:1,0) : RandomNumber(0,a:1)
    else " if a:2 >= 2
        return abs(RandomNumber()) % (abs(a:2 - a:1) + 1) + a:1
    endif
endfunction

function! s:source_rc(path)
  execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
endfunction

call s:source_rc('init.vim')
call s:source_rc('edit.vim')
call s:source_rc('view.vim')
call s:source_rc('encoding.vim')
call s:source_rc('filetype.vim')
call s:source_rc('mapping.vim')
call s:source_rc('unix.vim')
call s:source_rc('plugin.vim')

" General {

    " Most prefer to automatically switch to the current file directory when " a new buffer is opened
    "autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    " Spell
    "set balloonexpr=FoldSpellBalloon()
    "set ballooneval
    "set balloondelay=400

    " Remember info about open buffers on close
" }


" Functions {
    " Show suggestion of error spell
    function! FoldSpellBalloon()
        let foldStart = foldclosed(v:beval_lnum)
        let foldEnd = foldclosedend(v:beval_lnum)
        let lines = []
        if foldStart < 0
            " Detect if we are on a misspelled word
            let lines = spellsuggest(spellbadword(v:beval_text)[0], 5, 0)
        else
            " we are in a fold
            let numLines = foldEnd - foldStart + 1
            " if we have too many lines in fold, show only the first 14
            " and the last lines
            if numLines > 31
                let lines = getline(foldStart, foldStart + 14)
                let lines += ['--Snipped ' . (numLines - 30) . ' lines --']
                let lines += getline(foldEnd - 14, foldEnd)
            else
                "less than 30 lines, lets show all of them
                let lines = getline(foldStart, foldEnd)
            endif
        endif
        return join(lines, has("ballon_multiline") ? "\n" : " ")
    endfunction
" }

