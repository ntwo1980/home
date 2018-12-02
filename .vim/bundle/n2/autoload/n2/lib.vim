function! n2#lib#BufOnly(buffer, bang)
    if a:buffer == ''
        " No buffer provided, use the current buffer.
        let buffer = bufnr('%')
    elseif (a:buffer + 0) > 0
        " A buffer number was provided.
        let buffer = bufnr(a:buffer + 0)
    else
        " A buffer name was provided.
        let buffer = bufnr(a:buffer)
    endif

    let last_buffer = bufnr('$')

    let delete_count = 0
    let n = 1
    while n <= last_buffer
        if n != buffer && buflisted(n)
            if a:bang == '' && getbufvar(n, '&modified')
                echohl ErrorMsg
                echomsg 'No write since last change for buffer'
                            \ n '(add ! to override)'
                echohl None
            else
                silent exe 'bdel' . a:bang . ' ' . n
                if ! buflisted(n)
                    let delete_count = delete_count+1
                endif
            endif
        endif
        let n = n+1
    endwhile

    if delete_count == 1
        echomsg delete_count "buffer deleted"
    elseif delete_count > 1
        echomsg delete_count "buffers deleted"
    endif

endfunction

function! n2#lib#VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

function! n2#lib#AlignComment(mode) range
    if a:mode == 'n'
        let firstLine = a:firstline
        let lastLine = a:lastline
    elseif a:mode == 'v'
        let firstLine = line("'<")
        let lastLine = line("'>")
    else
        return
    endif

    if firstLine > lastLine
        let topLine = lastLine
        let bottomLine = firstLine
    else
        let topLine = firstLine
        let bottomLine = lastLine
    endif

    while topLine <= bottomLine
        let currentLine = getline(topLine)

        if currentLine !~ '^\s*;'
            let commentIndex = stridx(currentLine, ';')
            if commentIndex > 0 && commentIndex < 50
                execute ":normal! ". topLine . "G" . commentIndex . "|i" . repeat(' ', 50 - commentIndex)
            endif
        endif
        let topLine = topLine + 1
    endwhile
endfunction

function! n2#lib#ReplaceModifiedString()
    if &modified == 1
        let l = line(".")
        let c = col(".")

        execute "1," . 15 . "g/Modified\\s*:\\s*\\zs.*\\ze/s//" . ' ' . strftime("%Y-%m-%d %T")

            call cursor(l, c)
    endif
endfunction

" Strip whitespace
function! n2#lib#StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e

    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

let s:N2_easymotion_enabled = 0
function! n2#lib#ToggleSearchType()
    if s:N2_easymotion_enabled == 0
        nmap / <Plug>(easymotion-sn)
        xmap / <Plug>(easymotion-sn)
        omap / <Plug>(easymotion-sn)
        map  n <Plug>(easymotion-next)zz
        map  N <Plug>(easymotion-prev)zz

        let s:N2_easymotion_enabled = 1
    else
        nunmap /
        xunmap /
        ounmap /
        unmap n
        unmap N
        map n nzz
        map N Nzz

        let s:N2_easymotion_enabled = 0
    endif
endfunction

function! n2#lib#CleverCr()
    if pumvisible()
        if neosnippet#expandable()
            let exp = "\<Plug>(neosnippet_expand)"
            return exp . neocomplete#mappings#close_popup()
        else
            return neocomplete#mappings#close_popup()
        endif
    else
        let prevChar = s:GetPrevChar()

        if prevChar == "{"
            return "\<CR>\<CR>\<C-O>k\<Tab>"
        else
            return "\<CR>"
        endif
    endif
endfunction

function! n2#lib#vimfiler_settings() "{
    call vimfiler#set_execute_file('vim', ['vim', 'notepad'])
    call vimfiler#set_execute_file('txt', 'vim')

    " Overwrite settings.
    nmap <buffer><expr><cr> vimfiler#smart_cursor_map("\<plug>(vimfiler_expand_tree)", "\<plug>(vimfiler_edit_file)")
    nmap <buffer> q <Plug>(vimfiler_exit)
    nmap <buffer> Q <Plug>(vimfiler_hide)
    nnoremap <buffer> J
            \ <C-u>:Unite  -default-action=lcd directory_mru<CR>
    nmap <silent><buffer> dd <Plug>(vimfiler_delete_file)
    try
        nunmap <buffer> <C-l>
    catch
    endtry

    nmap <buffer> o <Nop>
    "nmap <buffer> <Tab> <Plug>(vimfiler_switch_to_other_window)
endfunction"}

function! n2#lib#JavaScriptFold()
	setl foldmethod=syntax
	setl foldlevel=1
	syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
endfunction

" Toggle options. "{
function! n2#lib#ToggleOption(option_name)
    execute 'setlocal' a:option_name.'!'
    execute 'setlocal' a:option_name.'?'
endfunction  "}

" Toggle variables. "{
function! n2#lib#ToggleVariable(variable_name)
    if eval(a:variable_name)
        execute 'let' a:variable_name.' = 0'
    else
        execute 'let' a:variable_name.' = 1'
    endif
    echo printf('%s = %s', a:variable_name, eval(a:variable_name))
endfunction  "}

" Toggle menu and toolbar. "{
function! n2#lib#ToggleMenu()
    if has("gui_running")
        if &guioptions =~# 'T'
            set guioptions-=T
            set guioptions-=m
        else
            set guioptions+=T
            set guioptions+=m
        endif
    endif
endfunction  "}

function! n2#lib#Bufferize(cmd)
  let cmd = a:cmd
  redir => output
  silent exe cmd
  redir END

  new
  call setline(1, split(output, "\n"))
  set nomodified
endfunction

function! s:GetCharAhead(len)
    if col('$') == col('.')
        return "\0"
    endif
    return strpart(getline('.'), col('.')-2 + a:len, 1)
endfunction

function! s:GetCharBehind(len)
    if col('.') == 1
        return "\0"
    endif
    return strpart(getline('.'), col('.') - (1 + a:len), 1)
endfunction

function! s:GetNextChar()
    return s:GetCharAhead(1)
endfunction

function! s:GetPrevChar()
    return s:GetCharBehind(1)
endfunction
