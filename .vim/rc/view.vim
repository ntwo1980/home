if has("gui_running")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=e
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guitablabel=%M\ %t
endif

if IsWindows()
    set guifont=Ubuntu_Mono_derivative_Powerlin:h12:cANSI
    colorscheme solarized " Load a colorscheme
else
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 13
endif

 "Open MacVim in fullscreen mode
if has("gui_macvim")
    set fuoptions=maxvert,maxhorz
    au GUIEnter * set fullscreen
endif

if filereadable(expand("~/.vim/bundle/solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    colorscheme solarized " Load a colorscheme
endif
set number " Line numbers on
set relativenumber "show relative number
set list "Show <TAB> and <CR>
if IsWindows()
  set listchars=tab:>-,trail:-,extends:>,precedes:<
else
  set listchars=tab:▸\ ,trail:-,extends:»,precedes:«,nbsp:%
endif
if has('statusline')
    set laststatus=2 " Always display statusline
endif
set cmdheight=2
set noshowcmd " Not show command on statusline
set whichwrap=b,s,h,l,<,>,[,],~ " Backspace and cursor keys wrap too
set shortmess=aTI " Not display greeting message when start
 "Don't create backup.
set nowritebackup
set nobackup
set noswapfile
set backupdir-=.
 "Disable bell
set noerrorbells
set novisualbell
set t_vb=
set wildmenu " Show list instead of just completing
set wildmode=list:longest,full " Command <Tab> completion, list matches, then longest common part, then all.
set wildignore+=*.o,*~,*pyc
if IsWindows()
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif
set history=1000 " Store a ton of history (default is 20)
set showfulltag " Display all the information of tag
set wildoptions=tagfile " Can supplement a tag in command line
set completeopt=menuone
set complete=.,w,b,t,i
set pumheight=20 " Set popup menu max height
set report=0 " Always report changes
set nostartofline " Maintain a current line at time of movement as much as possible
set splitbelow
set splitright
set winwidth=30
set winheight=1
set cmdwinheight=5
set noequalalways
set helpheight=12
set previewheight=12
set lazyredraw " Not redraw while macro executing
set ttyfast     " Assume fast terminal connection
set display=lastline
set viewoptions=folds,cursor,unix,slash " Better Unix / Windows compatibility
set conceallevel=2 concealcursor=iv
set colorcolumn=79,99  " highlight column
set textwidth=0
set tabpagemax=15 " Only show 15 tabs
set showmode " Display the current mode
autocmd WinLeave * set nocursorline nocursorcolumn
autocmd WinEnter * set cursorline cursorcolumn
set cursorline " Highlight current line
highlight CursorLine guibg=black ctermbg=16
set cursorcolumn
highlight CursorColumn guibg=black ctermbg=16
highlight clear SignColumn " SignColumn should match background for things like vim-gitgutter
highlight clear LineNr " Current line number row will have same background color in relative mode.
if has('cmdline_info')
    set ruler " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    if !has('win32unix')
        set showcmd " Show partial commands in status line and selected characters/lines in visual mode
    endif
endif
set linespace=0 " No extra spaces between rows
set scrolljump=5 " Lines to scroll when cursor leaves screen
set scrolloff=3 " Minimum lines to keep above and below cursor
behave xterm
set guicursor=a:blinkon0
set langmenu=_en_US
let $LANG='en_US'
set nowrap " Wrap long lines
"set linebreak
"set showbreak=\
"set breakat=\ \	;:,!?
set winaltkeys=no
set switchbuf=useopen,usetab,newtab

