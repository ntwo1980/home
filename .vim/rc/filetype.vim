set autoindent " Indent at the same level of the previous line
set smartindent
set formatoptions-=ro
set formatoptions+=mMBl

augroup MyAutoCmd
    autocmd FileType help autocmd BufEnter <buffer> wincmd L

    autocmd FileType,Syntax * call s:my_on_filetype()

    " Auto reload VimScript
    autocmd BufWritePost,FileWritePost *.vim source <afile>

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    autocmd FileType gitcommit autocmd BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown,mkd setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType markdown,mkd setlocal formatoptions+=n2
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " Update filetype.
    autocmd BufWritePost *
    \ if &l:filetype ==# ''
    \ |   filetype detect
    \ | endif

    autocmd FileType html
        \ setlocal includeexpr=substitute(v:fname,'^\\/','','') |
        \ setlocal path+=./;/

    " Remove trailing whitespaces and ^M chars
    autocmd FileType vim,c,cpp,java,go,php,javascript,python,twig,xml,yml,perl,gas,markdown,mkd,ps1 autocmd BufWritePre <buffer> call n2#lib#StripTrailingWhitespace()
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType vim setlocal foldmarker={,} foldlevel=10 foldmethod=marker
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd BufNewFile,BufRead *.coffee set filetype=coffee
    autocmd BufNewFile,BufRead *.aspx set filetype=html
    autocmd BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent
    "autocmd BufWritePost *.py call Flake8()

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell setlocal nospell
    autocmd FileType asm set filetype=gas
    "autocmd FileType gas setlocal shiftwidth=8 tabstop=8 softtabstop=8 colorcolumn=51,79,99
    autocmd FileType gas setlocal shiftwidth=8 tabstop=8 softtabstop=8 colorcolumn=51,79,99 |
        \ nnoremap <silent> <buffer> <Leader>aa :<C-u>call n2#lib#AlignComment('n')<CR> |
        \ vnoremap <silent> <buffer> <Leader>aa :<C-u>call n2#lib#AlignComment('v')<CR>m'gv``

    autocmd FileType javascript call n2#lib#JavaScriptFold()

    " templates
    autocmd BufNewFile * silent! 0r ~/.vim/template/%:e.tpl

    autocmd BufNewFile *.asm silent!
        \ execute "1," . 15 . "g/$filename\\$/s//" . expand("%:t:r") . "/g"

    autocmd BufNewFile *.asm silent!
        \ execute "1," . 15 . "g/$fileroot\\$/s//" . expand("%:t:r") . "/g"

    autocmd BufNewFile *.asm silent!
        \ execute "1," . 15 . "g/$created\\$/s//" . strftime("%Y-%m-%d %T")

    autocmd BufWritePre *.asm silent! call n2#lib#ReplaceModifiedString()

    autocmd BufRead *.log :match ErrorMsg /\[Error]/

augroup END

let g:markdown_fenced_languages = [
      \  'bash=sh',
      \  'sh',
      \  'coffee',
      \  'css',
      \  'erb=eruby',
      \  'html',
      \  'javascript',
      \  'js=javascript',
      \  'json=javascript',
      \  'ruby',
      \  'sass',
      \  'xml',
      \  'vim',
      \]
" Syntax highlight for user commands.
augroup MyAutoCmd
  autocmd Syntax vim
        \ call s:set_syntax_of_user_defined_commands()
augroup END

function! s:set_syntax_of_user_defined_commands() "{{{
  redir => _
  silent! command
  redir END

  let command_names = join(map(split(_, '\n')[1:],
        \ "matchstr(v:val, '[!\"b]*\\s\\+\\zs\\u\\w*\\ze')"))

  if command_names == '' | return | endif

  execute 'syntax keyword vimCommand ' . command_names
endfunction"}}}

function! s:my_on_filetype() "{{{
  " Use FoldCCtext().
  "if &filetype !=# 'help'
    "setlocal foldtext=FoldCCtext()
  "endif
  if !&l:modifiable
    setlocal nofoldenable
    setlocal foldcolumn=0

    if v:version >= 703
      setlocal colorcolumn=
    endif
  endif
endfunction "}}}

" Do not display completion messages
" Patch: https://groups.google.com/forum/#!topic/vim_dev/WeBBjkXE8H8
set noshowmode
try
  set shortmess+=c
catch /^Vim\%((\a\+)\)\=:E539: Illegal character/
  autocmd MyAutoCmd VimEnter *
        \ highlight ModeMsg guifg=bg guibg=bg |
        \ highlight Question guifg=bg guibg=bg
endtry

