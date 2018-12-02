" Easy escape
inoremap jj <ESC>
cnoremap <expr> j       getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j'
onoremap jj           <ESC>

nnoremap q :
vnoremap q :
nnoremap Q q
vnoremap Q q

nnoremap c "_c
vnoremap C "_C
xnoremap p pgvy
xnoremap P Pgvy

noremap ' `
noremap ` '

nnoremap <expr> ZZ (getline(1) ==# '' && 1 == line('$') ? ':bdelete<cr>' : 'ZZ')

" Toggle options and variables {
    nnoremap <silent> <BSLASH>n :<C-u>call n2#lib#ToggleOption('relativenumber')<CR>
    nnoremap <silent> <BSLASH>ar :<C-u>setlocal autoread<CR>
    nnoremap <silent> <BSLASH>s :<C-u>call n2#lib#ToggleOption('spell')<CR>
    nnoremap <silent> <BSLASH>w :<C-u>call n2#lib#ToggleOption('wrap')<CR>
    nnoremap <silent> <BSLASH>m :<C-u>call n2#lib#ToggleMenu()<CR>
"}

" AsyncRun {
    nnoremap <F5> :call <SID>compile_and_run()<CR>
    imap <F5> <C-O><F5>

    augroup ASYNCRUN
        autocmd!
        " Automatically open the quickfix window
        autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
    augroup END

    function! s:compile_and_run()
        exec 'w'
        if &filetype == 'c'
            exec "AsyncRun! gcc % -o %<; time ./%<"
        elseif &filetype == 'cpp'
        exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
        elseif &filetype == 'java'
        exec "AsyncRun! javac %; time java %<"
        elseif &filetype == 'sh'
        exec "AsyncRun! time bash %"
        elseif &filetype == 'python'
        exec "AsyncRun! python %"
        endif
    endfunction
"}

" Motion {

    " Easier moving in insert mode
    inoremap <C-a> <C-o>^
    "inoremap <C-e> <C-o>$
    inoremap <expr> <C-b> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
    inoremap <expr> <C-d> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
    inoremap <expr> <C-e> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"
    inoremap <expr> <C-f> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"
    inoremap <C-h> <C-o>h
    inoremap <C-j> <C-o>j
    inoremap <C-k> <C-o>k
    inoremap <C-l> <C-o>l

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    nnoremap go O<ESC>jo

    nnoremap H ^
    nnoremap L $

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " <C-a>, A: move to head.
    cnoremap <C-a>          <Home>
    " <C-b>: previous char.
    cnoremap <C-b>          <Left>
    " <C-d>: delete char.
    cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
    "cnoremap <C-d>          <Del>
    " <C-e>, E: move to end.
    cnoremap <C-e>          <End>
    " <C-f>: next char.
    cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
    " <C-n>: next history.
    cnoremap <C-n>          <Down>
    " <C-p>: previous history.
    cnoremap <C-p>          <Up>
    " <C-k>, K: delete to end.
    cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
        \ '' : getcmdline()[:getcmdpos()-2]<CR>

    noremap! <expr> <SID>transposition getcmdpos()>strlen(getcmdline())?"\<Left>":getcmdpos()>1?'':"\<Right>"
    noremap! <expr> <SID>transpose "\<BS>\<Right>".matchstr(getcmdline()[0 : getcmdpos()-2], '.$')
    cmap   <script> <C-T> <SID>transposition<SID>transpose
    " <C-y>: paste.
    if has('unnamedplus')
        cnoremap <C-y>          <C-r>+
    else
        cnoremap <C-y>          <C-r>""
    endif
" }

" Search {

    " :s with flag
    noremap & :&&<CR>    " g& repeat last :s on all lines.
    xnoremap & :&&<CR>
    nnoremap <silent> <leader>/ :nohlsearch<CR>

    " Search word under cursor
    map <F3> :execute "vimgrep /" . expand("<cword>") . "/j *" <Bar> cw<CR>

    xnoremap * :<C-u>call n2#lib#VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
    xnoremap # :<C-u>call n2#lib#VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

    " recursively vimgrep for word under cursor or selection if you hit leader-star
    "nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
    "vmap <leader>* :<C-u>call n2#lib#VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>

" }

" Edit {

    " Exit vim
    nnoremap <silent> zq :qall<CR>
    vnoremap <silent> zq :qall<CR>

    " Visual shifting (does not exit Visual mode)
    xnoremap < <gV
    xnoremap > >gV

    " Move visual block
    "vnoremap J :m '>+1<CR>gv=gv
    "vnoremap K :m '<-2<CR>gv=gv

    " Fast saving
    inoremap <silent><C-s> <C-O>:update<CR>
    nnoremap <silent><C-s> :update<CR>
    vnoremap <silent><C-s> <C-C>:update<CR>

    " Paste yanked
    nnoremap <Leader>p "0p
    nnoremap <Leader>P "0P
    xnoremap <leader>p "0p
    xnoremap <leader>P "0P

    nnoremap <silent><BS> <C-^>

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
    noremap <leader>ew :e <C-R>=fnameescape(expand('%:h')).'/'<CR>
    noremap <leader>es :sp <C-R>=fnameescape(expand('%:h')).'/'<CR>
    noremap <leader>ev :vsp <C-R>=fnameescape(expand('%:h')).'/'<CR>
    noremap <leader>eh :vsp ~/
    noremap <leader>et :tabe <C-R>=fnameescape(expand('%:h')).'/'<CR>
    noremap <leader>er :edit!<CR>

    " Select all
    nnoremap ga ggVG
    nnoremap gA ga
    "inoremap <C-a> <C-O>gg<C-O>gH<C-O>G
    " onoremap <C-a> <C-C>gggH<C-O>G
    " snoremap <C-a> <C-C>gggH<C-O>G
    " xnoremap <C-a> <C-C>ggVG

    " Visually select the text that was last edited/pasted
    nnoremap gV `[v`]

    " backspace in Visual mode deletes selection
    vnoremap <BS> d

    " For when you forget to sudo.. Really Write the file.
    cnoremap w!! w !sudo tee % >/dev/null

    " Open file in new buffer
    map gf :edit <cfile><CR>
" }

" Buffer, Window, Tab {

    " Buffer
    noremap <Right> <ESC>:bn<CR>
    noremap <Left> <ESC>:bp<CR>
    noremap gb :ls!<CR>:buffer<Space>
    noremap gB :ls!<CR>:sbuffer<Space>
    noremap <silent> <leader>bc <ESC>:bd<CR>
    noremap <silent> <leader>ba :call n2#lib#BufOnly('vimfiler:explorer', '')<CR>
    noremap <silent> <leader>bo :call n2#lib#BufOnly('', '')<CR>
    noremap <silent> <leader>bn :enew<CR>

    " Tab
    noremap <silent> <leader>tn :tabnew<CR>
    noremap <silent> <leader>to :tabonly<CR>
    noremap <silent> <leader>tc :tabclose<CR>
    noremap <silent> <leader>tm :tabmove
    noremap <silent> <leader>t<leader> :tabnext

    " Window
    noremap <silent> <leader>wo :only<CR>
    noremap <silent> <leader>wc :close<CR>
    noremap <silent> <leader>wh <C-W>t<C-W>H
    noremap <silent> <leader>wk <C-W>t<C-W>K<C-w>=
    noremap <silent> <leader>wq :copen<CR>
    noremap <silent> <leader>w<Up> :exe "resize" . (winheight(0) * 2)<CR>
    noremap <silent> <leader>w<Down> :exe "resize" . (winheight(0) * 1/2)<CR>
    noremap <silent> <leader>w<Right> :exe "vertical resize" . (winwidth(0) * 3/2)<CR>
    noremap <silent> <leader>w<Left> :exe "vertical resize" . (winwidth(0) * 2/3)<CR>

    " Easier moving in tabs and windows
    noremap <C-J> <C-W>j
    noremap <C-K> <C-W>k
    noremap <C-L> <C-W>l
    noremap <C-H> <C-W>h
    noremap <Leader>- <C-W>_
    noremap <Leader><Bar> <C-W><Bar>
    noremap <Leader>= <C-w>=
    noremap <C-UP> <C-W>+
    noremap <C-DOWN> <C-W>-
    noremap <C-LEFT> <C-W><
    noremap <C-RIGHT> <C-W>>
    set wmw=0  " set the min width of a window to 0 so we can maximize others
    set wmh=0

    " List all buffers
    cnoremap ls ls!
    cnoremap ls! ls

" }

" Formatting {

    " Sort CSS properties
    nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
    " Format book name
    nnoremap <silent> <leader>tt gugu \| :s/[–:,(). ]\s*/-/g \| :s/--/-/g<CR>
    nnoremap <silent> <leader>ta ggVGgu \| :%s/\s*$/",/g \| :%s/^/"/g<CR>

" }

" Fold {

    " Code folding options
    nnoremap <leader>f0 :set foldlevel=0<CR>
    nnoremap <leader>f1 :set foldlevel=1<CR>
    nnoremap <leader>f2 :set foldlevel=2<CR>
    nnoremap <leader>f3 :set foldlevel=3<CR>
    nnoremap <leader>f4 :set foldlevel=4<CR>
    nnoremap <leader>f5 :set foldlevel=5<CR>
    nnoremap <leader>f6 :set foldlevel=6<CR>
    nnoremap <leader>f7 :set foldlevel=7<CR>
    nnoremap <leader>f8 :set foldlevel=8<CR>
    nnoremap <leader>f9 :set foldlevel=9<CR>
    nnoremap <leader>f- :set foldlevel=99<CR>

" }

" Others {

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " Change Working Directory to that of the current file
    cnoremap cd. lcd %:p:h

    " Easier horizontal scrolling
    noremap zl zL
    noremap zh zH

    if IsWindows()
        nnoremap <silent> <C-F5> :if expand("%:p:h") != "" \| exec "!start explorer.exe" expand("%:p:h:S") \| endif<CR>   " Open the folder containing the currently open file.
    endif

    " Execute command inserted in insert mode
    inoremap <silent> <F2> <Esc>@.<CR>

    " Exit
    "cnoremap ql q!

    " Help
    noremap <S-F1> <ESC>:exec "help ".expand("<cword>")<CR>

    " Output command into a new buffer for better readable format.
    command! -nargs=* -complete=command Bufferize call n2#lib#Bufferize(<q-args>)

" }

