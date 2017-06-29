" Welcome to my VIM config! This has been a work in progress since
" the summer of 2016 when I started my journey to learn VIM. 

"===================================================================="
"=========================== [ Beginning ] =========================="
"===================================================================="

" for the current millennium
" tells vim that it doesn't have to act like vi anymore
set nocompatible

" reload .vimrc"
nnoremap <leader>rv :source $MYVIMRC<CR>

" easy access to vimrc
noremap <F12>  <Esc>:tabnew $MYVIMRC<CR>

"===================================================================="
"========================== [ The Basics ] =========================="
"===================================================================="
set ruler          " Turns the ruler on
set number         " Line numbers
set numberwidth=4  " Width of the gutter
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
nnoremap <F1> <nop>            " turn off F1 key
set ttyfast                    " improved performance
set lazyredraw                 " only redraw when needed (better for large macros)

" natural splits
set splitbelow
set splitright

" set minimum height of a window
set winminheight=0


set linebreak "Vim will wrap long lines at a character in 'breakat' 
" rather than at the last character that fits on the screen

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

"===================================================================="
"======================= [ Mouse / Scrolling ] ======================"
"===================================================================="
nmap <ScrollWheelUp> 2<C-Y>    " Scrolling up
nmap <ScrollWheelDown> 2<C-E>  " Scrolling down
set mouse=a        " Enable mouse usage
set mousehide      " Hide the mouse cursor while typing

"===================================================================="
"========================= [ Spell Checking ] ======================="
"===================================================================="
set spell spelllang=en_us    " Set spell check to English
hi clear SpellBad
hi SpellBad cterm=underline  " Underline misspelled words
" change misspelled word
nnoremap z<Space> z=
" go to next/previous misspelled word
nnoremap zn ]s
nnoremap zN [s

"===================================================================="
"============================= [ Folds ] ============================"
"===================================================================="
"set foldcolumn=1
"set foldmethod=syntax

"===================================================================="
"======================== [ Tabs / Buffers ] ========================"
"===================================================================="
set autoindent
filetype plugin indent on
set tabstop=2
set softtabstop=2 
set shiftwidth=2
set expandtab

set showtabline=1                  " Show tab line when >1 tab open
nmap <leader>t :tabnew<CR>         " Open a new empty tab
nmap <Space>l :tabnext<CR>         " Move to the next tab
nmap <Space>h :tabprevious<CR>     " Move to the previous tab
nmap <leader>bq :bp <BAR> bd #<CR> " Close the current tab and move to the previous one
nmap <leader>bl :ls<CR>            " Show all open buffers and their status
nmap <F10> :bn<CR>                 " Next buffer
nmap <C-F10> :bp<CR>               " Previuous buffer

"===================================================================="
"========================= [ Color Scheme ] ========================="
"===================================================================="

syntax enable         " Enable syntax highlighting
set background=dark   " Solarized dark theme
colorscheme solarized " Solarized color scheme

"===================================================================="
"========================== [ Custom Maps ] ========================="
"===================================================================="

"draw line at the 81st column
let &colorcolumn=join(range(72,999),",")
let &colorcolumn="71,".join(range(400,999),",")

" toggle paste
set pastetoggle=<C-A-p>

" Normal moving over wrapped lines
nnoremap j gj
nnoremap k gk

" Shift-j/k scrolls the screen and centers the cursor
nnoremap J gjzz
nnoremap K gkzz

" Visual shifting (does not exit Visual mode)
"vnoremap < <gv
"vnoremap > >gv

" gg & G mark location
nnoremap gg mjgg
nnoremap G mjG

" Center the screen after jumping to a mark
nmap <expr> ' printf('`%c zz',getchar()) 

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Center the screen when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Easier to type, and I never use the default behavior
nnoremap H ^                " Jump to beginning of line
nnoremap L $                " Jump to end of line
vnoremap L g_               " Jump to end of line

" Auto curly braces
inoremap <F2> {<Esc>o}<Esc>O

" Auto capitalize WORD
inoremap <C-u> <esc>mzgUiw`za

" Helps 'COPE' with your problems
noremap <F4> :cp<CR>zz
noremap <F5> :cn<CR>zz

" Searches for all instances fo TODO and FIXME
command! Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw

" Generic auto fix indentation
nnoremap <F7> mzgg=G`zzz
inoremap <F7> <Esc>mzgg=G`zzza

" Sort highlighted lines
noremap S :sort<CR>

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

"===================================================================="
"=========================== [ Functions ] =========================="
"===================================================================="

" Toggle relative numbering, and set to absolute on loss of focus or insert mode
"set rnu
"function! ToggleNumbersOn()
"	set nu!
"	set rnu
"endfunction
"function! ToggleRelativeOn()
"	set rnu!
"	set nu
"endfunction
"autocmd FocusLost * call ToggleRelativeOn()
"autocmd FocusGained * call ToggleRelativeOn()
"autocmd InsertEnter * call ToggleRelativeOn()
"autocmd InsertLeave * call ToggleRelativeOn()

" Only show cursor line in the current window and in normal mode.
" It makes it easier to locate the cursor
augroup cline
  au!
  au WinLeave,InsertEnter * set nocursorline
  au WinEnter,InsertLeave * set cursorline
augroup END

