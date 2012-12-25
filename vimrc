" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup	       " do not keep a backup file
set history=100	       " keep 100 lines of command line history
set noruler	           " show the cursor position all the time
set number	           " show line numbers
set showcmd	           " display incomplete commands
set showmatch          " automaticaly verify ()
set autochdir          " chdir to dir, containing current file
set nofsync            " do write() only on :w
set incsearch	       " do incremental searching
set ignorecase         " ignore case during search
set smartcase          " ignore `ignorecase` when search string contains uppercase chars
set autoindent         " always set autoindenting on
"set foldmethod=indent
set smartindent        " smart indentation
set guifont=terminus
"set mouse=a            " use mouse
"set mousemodel=popup
"set mousehide          " hide mouse while typing
set termencoding=utf-8 " default charset
set tabstop=4          " a four-space tab indent width is the prefered coding style
set shiftwidth=4       " this allows you to use the < and > keys
set expandtab          " insert spaces instead of <TAB> character when the <TAB> key is pressed
set smarttab           " use the "shiftwidth" setting for inserting <TAB>s instead of the "tabstop"
set softtabstop=4      " delete 4 spaces with <BS>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set background=dark
  "highlight Comment ctermfg=blue  " blue comments
endif

set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ \ %P\ \ %l,%c
set laststatus=2
set wildmenu
set wildmode=list:longest,full

" turn off replace mode
imap <Ins> <c-o>i

" switch line numbers with <Space>
noremap <space> <esc>:set number!<cr> 

" switch automatic indentation
map <F5> :set ai! si! <cr>
imap <F5> <ESC>:set ai! si!<cr>i

" remove trailing spaces
nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" keep cursor on selected line while page scrolling
nmap <PageUp> <C-U><C-U>
imap <PageUp> <C-O><C-U><C-O><C-U>
nmap <PageDown> <C-D><C-D>
imap <PageDown> <C-O><C-D><C-O><C-D>

" switch between vim windows with Ctrl+Up, Ctrl+Down
map <C-Up> <C-W><Up>
map <C-Down> <C-W><Down>
imap <C-Up> <Esc><C-W><Up>i
imap <C-Down> <Esc><C-W><Down>k

" switch between tabs with Ctrl+Left, Ctrl+Right
map <C-H> gT
map <C-L> gt
imap <C-H> <Esc>gTi
imap <C-L> <Esc>gti

" Encoding menu
menu Encoding.koi8-r       :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866        :e ++enc=cp866<CR>
menu Encoding.utf-8        :e ++enc=utf8 <CR>
map <F8> :emenu Encoding.

map Q gq " Don't use Ex mode, use Q for formatting

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

if has("autocmd") " Only do this part when compiled with support for autocommands.
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype on
  filetype plugin on
  filetype indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " highlight trailing spaces
  au BufNewFile,BufRead * let b:mtrailingws=matchadd('ErrorMsg', '\s\+$', -1)
  " highlight tabs between spaces
  au BufNewFile,BufRead * let b:mtabbeforesp=matchadd('ErrorMsg', '\v(\t+)\ze( +)', -1)
  au BufNewFile,BufRead * let b:mtabaftersp=matchadd('ErrorMsg', '\v( +)\zs(\t+)', -1)
  " highlight long lines (>80)
  "au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
  "au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

  augroup END

else

endif " has("autocmd")


" Spell menu
"set spelllang=ru
"menu Spell.on :set spell<cr>
"menu Spell.off :set nospell<cr>
"menu Spell.language :set spelllang=
"map <M-F8> :emenu Spell.
"map <C-F8> :set spell!<cr>

" Build menu
"menu Build.build   :make<cr>
"menu Build.rebuild :make clean<cr>:make<cr>
"menu Build.clean   :make clean<cr>
"menu Build.test    :make test<cr>
"menu Build.custom  :make
"map  <M-F9> :emenu Build.
"build project
"map  <F9> :make<cr>
"vmap <F9> <esc>:make<cr>v
"imap <F9> <esc>:make<cr>i
" rebuild project
"map  <C-F9> :make<space>clean<space>compile<cr>
"vmap <C-F9> <esc>:make<space>clean<space>compile<cr>v
"imap <C-F9> <esc>:make<space>clean<space>compile<cr>i
" open compile results window
"imap <S-F9> <Esc>:copen<CR>
"nmap <S-F9> :copen<CR>
" next error
"imap <F6> <Esc>:cn<CR>i
"nmap <F6> :cn<CR>
" prev error
"imap <F5> <Esc>:cp<CR>i
"nmap <F5> :cp<CR>

" list pages with <Space>
"nmap <Space> <PageDown>

" dont loose selection in visual mode (very buggy)
"vmap < :<<CR>gv
"vmap > :><CR>gv

" todo: doxygen, comments(add,del)

"set wrapscan
"set wrapmargin=79


