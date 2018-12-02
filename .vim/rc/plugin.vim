" ale {
    let g:ale_linters = {
                \   'sh' : ['shellcheck'],
                \   'vim' : ['vint'],
                \   'html' : ['tidy'],
                \   'python' : ['pylint'],
                \   'markdown' : ['mdl'],
                \   'javascript' : ['eslint'],
                \}
    let g:ale_set_highlights = 0
    let g:ale_emit_conflict_warnings = 1
    " If emoji not loaded, use default sign
    try
        let g:ale_sign_error = emoji#for('boom')
        let g:ale_sign_warning = emoji#for('small_orange_diamond')
    catch
        " Use same sign and distinguish error and warning via different colors.
        let g:ale_sign_error = '•'
        let g:ale_sign_warning = '•'
    endtry
    let g:ale_echo_msg_format = '[#%linter%#] %s [%severity%]'
    let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']

    " For a more fancy ale statusline
    function! ALEGetError()
        let l:res = ale#statusline#Status()
        if l:res ==# 'OK'
            return ''
        else
            let l:e_w = split(l:res)
            if len(l:e_w) == 2 || match(l:e_w, 'E') > -1
                return ' •' . matchstr(l:e_w[0], '\d\+') .' '
            endif
        endif
    endfunction

    function! ALEGetWarning()
        let l:res = ale#statusline#Status()
        if l:res ==# 'OK'
            return ''
        else
            let l:e_w = split(l:res)
            if len(l:e_w) == 2
                return ' •' . matchstr(l:e_w[1], '\d\+')
            elseif match(l:e_w, 'W') > -1
                return ' •' . matchstr(l:e_w[0], '\d\+')
            endif
        endif
    endfunction

    "if g:spacevim_gui_running
        let g:ale_echo_msg_error_str = 'Error'
        let g:ale_echo_msg_warning_str = 'Warning'
    "else
    "    let g:ale_echo_msg_error_str = '✹ Error'
    "    let g:ale_echo_msg_warning_str = '⚠ Warning'
    "endif

    nmap <Leader>en <Plug>(ale_next)
    nmap <Leader>ep <Plug>(ale_previous)
" }

"autoclose {
    let g:AutoClosePairs_del = "`"
    let g:AutoClosePreserveDotReg=0
"}
"
"betterspace {
    let g:better_whitespace_filetypes_blacklist=['vimfiler']
"}
"
"commenter {
    let NERDDefaultNesting=0
    let g:NERDCustomDelimiters = {
        \ 'gas': { 'left': ';' },
    \ }
" }

" Ctags {
    " set tags=./tags;/,~/.vimtags

    " " Make tags placed in .git/tags file available in all levels of a repository
    " let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
    " if gitroot != ''
    "     let &tags = &tags . ',' . gitroot . '/.git/tags'
    " endif
" }

" easymotion {
    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_do_shade = 0
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_enter_jump_first = 1
    let g:EasyMotion_space_jump_first = 1
    let g:EasyMotion_keys = 'ASDFJKL;GHQWERUIOPZXCVNMTYB'
    let g:EasyMotion_use_upper = 1
    nmap s <Plug>(easymotion-s2)
    xmap s <Plug>(easymotion-s2)
    omap s <Plug>(easymotion-s2)
    map  f <Plug>(easymotion-f)
    map  F <Plug>(easymotion-F)
    map  t <Plug>(easymotion-t)
    map  T <Plug>(easymotion-T)
    nnoremap <silent> gs :call n2#lib#ToggleSearchType()<CR>
    map <Leader>j <Plug>(easymotion-bd-jk)
    map <Leader>k <Plug>(easymotion-bd-jk)
    map <Leader><leader>w <Plug>(easymotion-w)
    map <Leader><leader>W <Plug>(easymotion-W)
    map <Leader><leader>b <Plug>(easymotion-b)
    map <Leader><leader>B <Plug>(easymotion-B)
    map <Leader><leader>e <Plug>(easymotion-e)
    map <Leader><leader>E <Plug>(easymotion-E)
    map <Leader><leader>ge <Plug>(easymotion-ge)
    map <Leader><leader>gE <Plug>(easymotion-gE)
    hi EasyMotionTarget guifg=yellow ctermfg=yellow

    call n2#lib#ToggleSearchType()
" }

" indent_guides {
    if !exists('g:spf13_no_indent_guides_autocolor')
        let g:indent_guides_auto_colors = 1
    else
        " For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#212121 ctermbg=3
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4
    endif
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
" }

" jedi {
    "let g:neocomplete#enable_auto_select = 0
    let g:jedi#force_py_version = 3
    let g:jedi#popup_select_first=0
    set completeopt=longest,menuone
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#popup_on_dot = 0
" }

"markdown {
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_conceal = 0
    "let g:vim_markdown_initial_foldlevel=1
" }

" matchit {
    let b:match_ignorecase = 1
" }

" neocomplete {
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 0
    let g:neocomplete#min_syntax_length = 1
    let g:neocomplete#enable_auto_delimiter = 1
    let g:neocomplete#max_list = 100
    let g:neocomplete#force_overwrite_completefunc = 1
    let g:neocomplete#enable_refresh_always = 0
    let g:neocomplete#enable_insert_char_pre = 1
    let g:neocomplete#enable_auto_select = 0
    let g:neocomplete#disable_auto_complete = 0

    " Define keyword.
    let g:neocomplete#keyword_patterns = {}
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    imap <C-K> <Plug>(neosnippet_expand_or_jump)
    smap <C-K> <Plug>(neosnippet_expand_or_jump)

    imap <silent><expr><C-k> neosnippet#expandable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
            \ "\<C-E>" : "\<Plug>(neosnippet_expand_or_jump)")
    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

    inoremap <expr><C-G> neocomplete#undo_completion()

    " <CR> close popup and save indent or expand snippet
    imap <expr> <CR> n2#lib#CleverCr()

    " <CR>: close popup
    " <s-CR>: close popup and save indent.
    inoremap <expr><s-CR> pumvisible() ? neocomplete#close_popup()"\<CR>" : "\<CR>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    "inoremap <expr><C-E> neocomplete#cancel_popup()

    " <TAB>: completion.
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.sql = '[[:alpha:]_.][[:alnum:]_.]*'
    let g:neocomplete#sources#omni#input_patterns.javascript = '[^. \t]\.\%(\h\w*\)\?'
    let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
    let g:neocomplete#sources#omni#input_patterns.python = '\h\w*\|[^. \t]\.\w*'
    if !exists('g:neocomplete#sources')
        let g:neocomplete#sources = {}
    endif
    let g:neocomplete#sources.cs = ['omni']
    " . -> methods, :: -> class method, # -> instance method.
    "let g:neocomplete#force_omni_input_patterns['ruby'] = '[^. *\t]\.\w*\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    "let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

    if !exists('gg:neocomplete#sources#omni#functions')
        let g:neocomplete#sources#omni#functions = {}
    endif

    " if the key is '_', used for all filetypes.

    let g:neocomplete#sources#omni#functions['_'] = 'syntaxcomplete#Complete' " default syntax omni
    " rsense plugin -> RsenseCompleteFunction
    " vim-ruby plugin -> rubycomplete#Complete
    "let g:neocomplete#sources#omni#functions['ruby'] = 'rubycomplete#Complete'
    if has('python3/dyn') || has('python3')
        let g:neocomplete#sources#omni#functions['python'] = 'jedi#completions' " default python3 omni
    elseif has('python/dyn') || has('python')
        let g:neocomplete#sources#omni#functions['python'] = 'jedi#completions' " default python omni
    endif
    " clang compiler front / ctags / omni complete ==> C, cpp, Go
    "let g:neocomplete#sources#omni#functions['go'] = 'gocomplete#Complete' " plugin gocode
    "let g:neocomplete#sources#omni#functions['c'] = 'ccomplete#Complete' " default
    "let g:neocomplete#sources#omni#functions['cpp'] = 'omni#cpp#complete#Main' " plugin omnicppcomplete
    "let g:neocomplete#sources#omni#functions['hpp'] = 'omni#cpp#complete#Main' " plugin omnicppcomplete
    " - 'javascriptcomplete#CompleteJS' -- default javascript omni
    " - 'jscomplete#CompleteJS' -- jscomplete-vim plugin
    "let g:neocomplete#sources#omni#functions['javascript'] = 'jscomplete#CompleteJS' " jscomplete-vim plugin
    "let g:neocomplete#sources#omni#functions['haskell'] = 'necoghc#omnifunc' " neco-ghc plugin
    "let g:neocomplete#sources#omni#functions['clojure'] = 'vimclojure#OmniCompletion' " VimClojure plugin
    "let g:neocomplete#sources#omni#functions['html'] = 'htmlcomplete#CompleteTags' " html5 plugin
    let g:neocomplete#sources#omni#functions['sql'] = 'mysqlcomplete#Complete' " default
    let g:neocomplete#sources#omni#functions['VimFiler'] = 'vimfiler#complete' " default
    "let g:neocomplete#sources#omni#functions['r'] = 'rcomplete#CompleteR' " vim-R-plugin
    "let g:neocomplete#sources#omni#functions['php'] = 'phpcomplete#CompletePHP' " default / phpcomplete plugin
    "let g:neocomplete#sources#omni#functions['xquery'] = 'xquerycomplete#CompleteXQuery' " plugin XQuery-indentomnicompleteftplugin
    "let g:neocomplete#sources#omni#functions['cs'] = 'OmniSharp#Complete'

    nnoremap <silent> <BSLASH>c :NeoCompleteToggle<CR>
" }

" VimFiler {
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_file_icon = '-'
    let g:vimfiler_marked_file_icon = '*'

    call vimfiler#custom#profile('default', 'context', {
        \ 'auto_expand' : 1,
        \ 'parent' : 0,
        \ })

    let g:vimfiler_detect_drives = IsWindows() ? [
                \ 'C:/', 'D:/', 'E:/', 'F:/', 'G:/', 'H:/', 'I:/',
                \ 'J:/', 'K:/', 'L:/', 'M:/', 'N:/'] :
                \ split(glob('/mnt/*'), '\n') + split(glob('/media/*'), '\n') +
                \ split(glob('/Users/*'), '\n')

    let g:vimfiler_sendto = {
                \ 'unzip' : 'unzip %f',
                \ 'zip' : 'zip -r %F.zip %*',
                \ }

    noremap <silent> zee :VimFilerBufferDir -force-quit<CR>
    noremap <silent> zew :VimFiler -force-quit<CR>
    noremap <silent> zef :VimFiler -find -force-quit<CR>
    noremap <silent> zet :VimFilerExplorer -winminwidth=50 -split -toggle -no-quit<CR>

    autocmd MyAutoCmd FileType vimfiler call n2#lib#vimfiler_settings()
" }

" NerdTree {
    "noremap <C-E> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
    "noremap <leader>e :NERDTreeFind<CR>

    "let NERDTreeShowBookmarks=1
    "let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    "let NERDTreeChDirMode=0
    "let NERDTreeQuitOnOpen=1
    "let NERDTreeMouseMode=2
    "let NERDTreeShowHidden=1
    "let NERDTreeKeepTreeInNewTab=1
    "let g:nerdtree_tabs_open_on_gui_startup=0
" }

" Session Manager {
    set sessionoptions=buffers,curdir,folds,help,tabpages,winsize
    set sessionoptions+=unix,slash

    let g:session_default_overwrite = 0
    let g:session_autoload = 0
    let g:session_autosave = 0
    let g:session_persist_colors = 0
" }

" Signature {
    let g:SignatureMap = {
    \ 'Leader'             :  "m",
    \ 'PlaceNextMark'      :  "m,",
    \ 'ToggleMarkAtLine'   :  "m.",
    \ 'PurgeMarksAtLine'   :  "m-",
    \ 'PurgeMarks'         :  "m<Space>",
    \ 'PurgeMarkers'       :  "m<BS>",
    \ 'GotoNextLineAlpha'  :  "",
    \ 'GotoPrevLineAlpha'  :  "",
    \ 'GotoNextSpotAlpha'  :  "",
    \ 'GotoPrevSpotAlpha'  :  "",
    \ 'GotoNextLineByPos'  :  "]'",
    \ 'GotoPrevLineByPos'  :  "['",
    \ 'GotoNextSpotByPos'  :  "]`",
    \ 'GotoPrevSpotByPos'  :  "[`",
    \ 'GotoNextMarker'     :  "[+",
    \ 'GotoPrevMarker'     :  "[-",
    \ 'GotoNextMarkerAny'  :  "]=",
    \ 'GotoPrevMarkerAny'  :  "[=",
    \ 'ListLocalMarks'     :  "'?"
    \ }
" }

" snippet {
    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#scope_aliases = {}
    let g:neosnippet#scope_aliases['mkd'] = 'markdown,mkd'
    let g:neosnippet#snippets_directory='~/.vim/bundle/snippets/snippets,~/Documents/Data/snippets'
" }

" Startify

    let g:startify_enable_special = 0
    let g:startify_files_number   = 10
    let g:startify_relative_path  = 1
    let g:startify_change_to_dir  = 1
    let g:startify_custom_indices = ['f','g','h','a','d','l',';', 'w','r','u','o','p']

    let g:startify_list_order = [
      \ ['   LRU:'],
      \ 'files',
      \ ['   Bookmarks:'],
      \ 'bookmarks',
      \ ['   Sessions:'],
      \ 'sessions',
      \ ]

    let g:startify_skiplist = [
                \ 'COMMIT_EDITMSG',
                \ ]

    let g:startify_bookmarks = []

    if filereadable('C:/Users/nn1003/Documents/Knowledge/VS.md')
        let g:startify_bookmarks = g:startify_bookmarks + [{'0': 'C:/Users/nn1003/Documents/Knowledge/VS.md'}]
    endif

    if filereadable('C:/Users/nn1003/Documents/Knowledge/sql.md')
        let g:startify_bookmarks = g:startify_bookmarks + [{'1': 'C:/Users/nn1003/Documents/Knowledge/sql.md'}]
    endif

    if filereadable('C:/Users/nn1003/Documents/Knowledge/git.md')
        let g:startify_bookmarks = g:startify_bookmarks + [{'2': 'C:/Users/nn1003/Documents/Knowledge/git.md'}]
    endif
      "let g:startify_custom_header =
          "\ map(split(system('tips | cowsay -f apt'), '\n'), '"   ". v:val') + ['']

    autocmd User Startified call s:startify_settings()
    function! s:startify_settings()
        nnoremap <silent> <buffer> q :bd<CR>
    endfunction

    hi StartifyBracket ctermfg=240
    hi StartifyFile    ctermfg=147
    hi StartifyFooter  ctermfg=240
    hi StartifyHeader  ctermfg=114
    hi StartifyNumber  ctermfg=215
    hi StartifyPath    ctermfg=245
    hi StartifySlash   ctermfg=240
    hi StartifySpecial ctermfg=240

" }

" OmniSharp {
    "let g:Omnisharp_start_server = 0
    "let g:echodoc_enable_at_startup = 1

    "autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    "autocmd FileType cs nnoremap <leader>gi :OmniSharpFindImplementations<cr>
    "autocmd FileType cs nnoremap <leader>gt :OmniSharpFindType<cr>
    "autocmd FileType cs nnoremap <leader>gs :OmniSharpFindSymbol<cr>
    "autocmd FileType cs nnoremap <leader>gu :OmniSharpFindUsages<cr>
    "autocmd FileType cs nnoremap <leader>gm :OmniSharpFindMembers<cr> "finds members in the current buffer
    " cursor can be anywhere on the line containing an issue
    "autocmd FileType cs nnoremap <leader>gf :OmniSharpFixIssue<cr>
    "autocmd FileType cs nnoremap <leader>gx :OmniSharpFixUsings<cr>
    "autocmd FileType cs nnoremap <leader>gl :OmniSharpTypeLookup<cr>
    "autocmd FileType cs nnoremap <leader>gd :OmniSharpDocumentation<cr>
    "autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr> "navigate up by method/property/field
    "autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr> "navigate down by method/property/field
"}

"surround {
    "let g:surround_no_mappings=1
    "nmap dq  <Plug>Dsurround
    "nmap cq  <Plug>Csurround
    "nmap yq  <Plug>Ysurround
    "nmap yQ  <Plug>YSurround
    "nmap yqq <Plug>Yssurround
    "nmap yQq <Plug>YSsurround
    "nmap yQQ <Plug>YSsurround
    "xmap Q   <Plug>VSurround
    "xmap gQ  <Plug>VgSurround
    "imap <C-Q> <Plug>Isurround
"}

" Tabularize {
    nnoremap <silent> <Leader>a& :Tabularize /&<CR>
    vnoremap <silent> <Leader>a& :Tabularize /&<CR>
    nnoremap <silent> <Leader>a= :Tabularize /=<CR>
    vnoremap <silent> <Leader>a= :Tabularize /=<CR>
    nnoremap <silent> <Leader>a; :Tabularize /;<CR>
    vnoremap <silent> <Leader>a; :Tabularize /;<CR>
    nnoremap <silent> <Leader>a: :Tabularize /:<CR>
    vnoremap <silent> <Leader>a: :Tabularize /:<CR>
    nnoremap <silent> <Leader>a:: :Tabularize /:\zs<CR>
    vnoremap <silent> <Leader>a:: :Tabularize /:\zs<CR>
    nnoremap <silent> <Leader>a, :Tabularize /,<CR>
    vnoremap <silent> <Leader>a, :Tabularize /,<CR>
    nnoremap <silent> <Leader>a,, :Tabularize /,\zs<CR>
    vnoremap <silent> <Leader>a,, :Tabularize /,\zs<CR>
    nnoremap <silent> <Leader>a<Bar> :Tabularize /<Bar><CR>
    vnoremap <silent> <Leader>a<Bar> :Tabularize /<Bar><CR>
    nnoremap <silent> <Leader>aa :Tabularize /<Bar><CR>
" }

" unite {

    call unite#custom#profile('default', 'context', {
        \ 'start_insert' : 1,
        \ 'vertical' : 1,
        \ })

    "let g:unite_enable_start_insert = 1
    let g:unite_source_history_yank_enable = 1
    let g:unite_source_rec_max_cache_file = 5000
    let g:unite_source_history_yank_save_clipboard = 1
    call unite#filters#matcher_default#use(['matcher_fuzzy'])

    nnoremap <silent> <leader>fb  :<C-u>Unite buffer file_mru bookmark file<CR>
    nnoremap <silent> <leader>fab :<C-u>UniteBookmarkAdd<CR>
    nnoremap <silent> <leader>fr  :<C-u>Unite register<CR>
    nnoremap <silent> <leader>fo  :<C-u>Unite -no-quit -keep-focus -auto-preview outline<CR>
    nnoremap <silent> <leader>fc  :<C-u>Unite -auto-preview colorscheme<CR>
    nnoremap <silent> <leader>fh  :<C-u>Unite help<CR>
    nnoremap <silent> <leader>fma :<C-u>Unite mapping<CR>
    nnoremap <silent> <leader>fme :<C-u>Unite output:message<CR>
    nnoremap <silent> <leader>fj :<C-u>UniteWithBufferDir -auto-preview mark change jump<CR>
    "nnoremap <silent> <leader>fs
        "\ :<C-u>Unite -no-split  buffer file_rec:! file file/new<CR>
    nnoremap <silent> <leader>fs :<C-u>Unite session session/new<CR>
    nnoremap <silent> <leader>fw :<C-u>Unite window<CR>
    nnoremap <silent> <leader>fn :<C-u>UniteWithBufferDir -no-split
        \ file directory file/new directory/new<CR>
    nnoremap <silent> <leader>fy :<C-u>Unite -no-split history/yank <CR>

    autocmd MyAutoCmd FileType unite call s:unite_settings()
    function! s:unite_settings()
        call unite#custom#alias('file', 'h', 'left')

        nmap <buffer> q <Plug>(unite_all_exit)
        nmap <buffer> Q <Plug>(unite_exit)
        imap <buffer> <UP> <Nop>
        imap <buffer> <Down> <Nop>
        imap <buffer> <C-j> <Plug>(unite_select_next_line)
        imap <buffer> <C-k> <Plug>(unite_select_previous_line)
        imap <buffer> jj <Plug>(unite_insert_leave)
        imap <buffer> <Tab> <Plug>(unite_complete)
        nmap <buffer> <C-g> <Plug>(unite_print_candidate)
        imap <buffer> ; <Plug>(unite_quick_match_default_action)
        nmap <buffer> ; <Plug>(unite_quick_match_default_action)
        nnoremap <silent><buffer><expr> dd
                \ unite#smart_map('dd', unite#do_action('delete'))
        nmap <buffer> <C-z> <Plug>(unite_toggle_transpose_window)
        imap <buffer> <C-z> <Plug>(unite_toggle_transpose_window)
        nnoremap <silent><buffer> <Tab> <C-w>w
        try
            nunmap <buffer> <C-l>
        catch
        endtry
        imap <silent><buffer><expr> l
                \ unite#smart_map('l', unite#do_action('default'))
    endfunction
    " }

    " vim-airline {
    " Set configuration options for the statusline plugin vim-airline.
    " Use the powerline theme and optionally enable powerline symbols.
    " To use the symbols , , , , , , and .in the statusline
    " segments add the following to your .vimrc.before.local file:
    " let g:airline_powerline_fonts=1
    " If the previous symbols do not render for you then install a
    " powerline enabled font.
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#buffer_nr_show = 1
        let g:airline#extensions#tabline#fnamemod = ':t'
        let g:airline_section_z = '%3p%% %#__accent_bold#%4l%#__restore__#/%L%:%3c'
        let airline_themes = [
            \ 'badwolf',
            \ 'bubblegum',
            \ 'dark',
            \ 'kolor',
            \ 'laederon',
            \ 'lucius',
            \ 'luna',
            \ 'molokai',
            \ 'powerlineish',
            \ 'raven',
            \ 'serene',
            \ 'sol',
            \ 'solarized',
            \ 'ubaryd',
            \ ]
        let g:airline#extensions#ale#enabled=1

        let rnd = RandomNumber(1, 14)
        "let g:airline_theme = airline_themes[rnd]

        if !IsCygWin()
            let g:airline_powerline_fonts=1
        endif
        let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
        let g:airline#extensions#quickfix#location_text = 'Location'
" }

" Vimux {
    noremap <Leader>rl :wa<CR> :VimuxRunLastCommand<CR>
    noremap <Leader>vi :wa<CR> :VimuxInspectRunner<CR>
    noremap <Leader>vk :wa<CR> :VimuxInterruptRunner<CR>
    noremap <Leader>vx :wa<CR> :VimuxClosePanes<CR>
    noremap <Leader>vp :VimuxPromptCommand<CR>
    vnoremap <Leader>vs "vy :call VimuxRunCommand(@v)<CR>
    nnoremap <Leader>vs vip<LocalLeader>vs<CR>
"}

" Db {
    let g:omni_sql_include_owner = 0
    let g:dbext_default_dict_show_owner = 0
    let g:dbext_default_type = 'SQLSRV'
    let g:dbext_default_user = 'sa'
    let g:dbext_default_passwd = 'SM7sm7!@#$%12345'
    let g:dbext_default_buffer_lines = 30
    let g:dbext_default_display_cmd_line = 0
    let g:dbext_default_delete_temp_file = 1
    let g:dbext_default_SQLSRV_bin = "SQLCMD"
    let g:dbext_default_SQLSRV_cmd_options = '-Y 20 -r -b'
    let g:dbext_default_profile_SQLSRV = 'srvname=192.168.1.245\SQL2005:dbname=SystemManager7.2_MPOFanout:bin_path=C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\110\Tools\Binn'
    let g:dbext_default_profile = 'SQLSRV'

    autocmd BufNewFile,BufRead *.sql call s:sql_settings()
    function! s:sql_settings()
        autocmd!
        nmap <buffer> <F5> <Plug>DBExecSQLUnderCursor
        vmap <buffer> <F5> <Plug>DBExecVisualSQL
        imap <buffer> <F5> <C-O><Plug>DBExecSQLUnderCursor
        nmap <buffer> <F6> :DBResultsClose<CR>
        vmap <buffer> <F6> :DBResultsClose<CR>
        imap <buffer> <F6> <C-O>:DBResultsClose<CR>
    endfunction
" }

