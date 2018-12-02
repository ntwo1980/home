set nocompatible " Must be first line
let mapleader="\<space>"
let g:mapleader="\<space>"

if IsWindows()
    set shellslash  "use forward slash for shell file names
    let &runtimepath = join([
        \ expand('$HOME/.vim'),
        \ expand('$VIM/vimfiles'),
        \ expand('$VIMRUNTIME'),
        \ expand('$HOME/.vim/after'),
        \ expand('$VIM/vimfiles/after')], ',')
endif

" set augroup
augroup MyAutoCmd
    autocmd!
augroup END

let g:loaded_netrwPlugin = 1
let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimballPlugin = 1

" pathogen
call pathogen#infect()
"call pathogen#helptags()

