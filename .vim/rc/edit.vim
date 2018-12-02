set background=dark " Assume a dark background
filetype plugin indent on " Automatically detect file types.
syntax on " Syntax highlighting
set noshelltemp
set mouse=  " Disable mouse
set mousehide " Hide the mouse cursor while typing
scriptencoding utf-8
set nrformats-=octal " always assume decimal numbers
set smarttab
set expandtab " Tabs are spaces, not tabs
set shiftround
set shiftwidth=4 " Use indents of 4 spaces
set tabstop=4 " An indentation every four columns
set softtabstop=4 " Let backspace delete indent
set nojoinspaces " Prevents inserting two spaces after punctuation on a join (J)
set pastetoggle=<F12> " pastetoggle (sane indentation on pastes)
if has('unnamedplus')
   set clipboard=unnamedplus
else
   set clipboard=unnamed
endif
set backspace=indent,eol,start " Backspace for dummies
set showmatch " Show matching brackets/parenthesis
set cpoptions-=m
set matchtime=10
set matchpairs+=<:> " Highlight <>
set hidden " Allow buffer switching without saving
set infercase " Ignore case on insert completion
set foldenable " Auto fold code
set foldcolumn=1
set foldmethod=syntax
set grepprg=internal " Use vimgrep
"Edit preference file
nnoremap <S-F9> <ESC>:e $MYVIMRC<CR>
autocmd MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC | redraw
set timeoutlen=3000 " mapping timeout
set ttimeoutlen=100 " keycode timeout
set updatetime=1000 " CursorHold time
set directory-=. " Set swap directory
"set virtualedit=all
set virtualedit=onemore
set keywordprg=:help
set shortmess+=filmnrxoOtT " Abbrev. of messages (avoids 'hit enter')
set history=1000 " Store a ton of history (default is 20)
"set spell " Spell checking on
set spellfile=~/.vim/spell/en.utf-8.add
set spelllang=en_us
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set encoding=utf8
set fileformats=unix,dos,mac " Use Unix as the standard file type
set hidden " Allow buffer switching without saving
"set iskeyword-=. "'.'is an end of word designator
"set iskeyword-=# "'#'is an end of word designator
"set iskeyword-=- "'-'is an end of word designator
set isfname-== " Exclude = from isfilename
set magic
set incsearch " Find as you type search
set hlsearch " Highlight search terms
set ignorecase " Case insensitive search
set smartcase " Case sensitive when uc present
set autoread
set viminfo=%,<500,'100,/50,:100,h,f1
augroup MyAutoCmd
   "autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

