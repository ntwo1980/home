if !IsWindows()
    if executable('zsh')
        set shell=zsh
    else
        set shell=bash
    endif
else
    set shell=c:\windows\system32\cmd.exe
endif

let $PATH = expand('~/bin').':/usr/local/bin/:'.$PATH

if has('gui_running')
    finish
endif

set t_Co=256

