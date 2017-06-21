" Welcome to my VIM config! This has been a work in progress since
" the summer of 2016 when I started my journey to learn VIM. 

"===================================================================="
"=========================== [ Begining ] ==========================="
"===================================================================="

" for the current millennium
" tells vim that it doesn't have to act like vi anymore
set nocompatible

" reload .vimrc"
nnoremap <leader>rv :source $MYVIMRC<CR>

" easy access to vimrc
noremap <F12>  <Esc>:tabnew $MYVIMRC<CR>

"draw line at the 81st column
let &colorcolumn=join(range(72,999),",")
let &colorcolumn="71,".join(range(400,999),",")

" toggle paste
set pastetoggle=<C-A-p>

"===================================================================="
"========================= [ Colorscheme ] =========================="
"===================================================================="

syntax enable         " enable syntax highlighting
set background=dark   " solarized dark theme
colorscheme solarized " solarized color scheme

"===================================================================="
"========================== [ The Basics ] =========================="
"===================================================================="
set number         " Line numbers

set mouse=a        " Enable mouse support

set shortmess=atI  " No help Uganda information
set incsearch      " Find as you type search
set nohlsearch     " No highlight search terms
set ignorecase     " Case in-sensitive search
set smartcase      " Case sensitive when uc present
set autoread       " Automatically read a file changed outside of vim
set autowrite      " Automatically write a file when leaving a modified buffer
set hidden         " Allow buffer switching without saving
set showcmd        " Show partial commands in status line and Selected characters/lines in visual mode
set showmode       " Display current mode
"set showmatch      " Show matching brackets/parentthesis
set matchtime=5    " Show matching time
set laststatus=2   " Always show status line
filetype plugin indent on      " Automatically detect file types
set linespace=0                " No extra spaces between rows
set backspace=indent,eol,start " Backspace for dummies
set backupdir=~/.vim/backup    " Set the backup directory
set directory=~/.vim/swap      " Set the swap files directory
nnoremap <F1> <nop>

set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶

set history=1000               " Number of commands saved in the history

if has('clipboard')
  set clipboard=unnamedplus    " Set up the clipboard
endif

if has('persistent_undo')
  set undodir=~/.vim/undo/ " Set undo file directory
  set undofile             " Persistent undo on
  set undolevels=1000      " Maximum number of changes that can be undone
  set undoreload=10000     " Maximum number lines to save for undo on a buffer reload
endif

" Normal moving over wrapped lines
nnoremap j gj
nnoremap k gk

" Shift-j/k scrolls the screen and centers the cursor
nnoremap J gjzz
nnoremap K gkzz

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
