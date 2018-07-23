"=============================================================================="
"================================ [ Beginning ] ==============================="
"=============================================================================="

"draw line at the 81st column
let &colorcolumn=join(range(82,999),",")
let &colorcolumn="81,".join(range(400,999),",")

" for the current millennium
" tells vim that it doesn't have to act like vi anymore
set nocompatible

" Set leader to space ( become a space leader )
let mapleader="\<Space>"

" reload .vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>

" Live update your vimrc when you modify it ! ! !
augroup reload_vimrc
autocmd!
autocmd BufWritePost *.vimrc source $MYVIMRC
augroup END

syntax enable           " Enable syntax highlighting
set background=dark     " Set background to dark/light
colorscheme solarized   " Solarized color scheme

"-============================================================================="
"=============================== [ The Basics ] ==============================="
"=============================================================================="

set ruler                         " Turns the ruler on
set number                        " Line numbers
set rnu                           " Use relative line numbers
set shortmess=I                   " No help Uganda information
set incsearch                     " Find as you type search
set hlsearch                      " highlight all mached search terms
set ignorecase                    " Case in-sensitive search
set smartcase                     " Case sensitive when uc present
set autoread                      " Automatically read a file changed outside of vim
set autowrite                     " Automatically write a file when leaving a modified buffer
set hidden                        " Allow buffer switching without saving
set showcmd                       " Show partial commands on the status line and selected characters/lines in visual mode
set showmode                      " Display current mode (normal, insert, visual, etc.)
set ttyfast                       " Improved performance
set lazyredraw                    " Only redraw when needed (better for large macros)
" set laststatus=2
set ttimeoutlen=50                " Time in milisenconds that is waited while pressing a key combination
set encoding=UTF-8
set termencoding=UTF-8
set fileencodings=UTF-8,ucs-bom,gb18030,gbk,gb2312,cp936
set splitbelow                    " Open horizontal splits below
set splitright                    " Open verticle splits to the right

set linebreak                     " Vim will wrap long lines at a character in 'breakat'
                                  " rather than at the last character that fits on the screen
" Set the system clipboard
set clipboard=unnamedplus,unnamed,autoselect

":set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
"set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶
set listchars=tab:→\ ,trail:~,extends:↷,precedes:↶
set list
set pastetoggle=<F1>              " Toggle paste mode

set wildmode=longest,list,full    " Match the longest and display the full list of matches
set wildmenu

"=============================================================================="
"============================ [ Mouse / Scrolling ] ==========================="
"=============================================================================="
set mouse=a                       " Enable mouse usage
set mousehide                     " Hide the mouse cursor while typing

"=============================================================================="
"============================== [ Spell Checking ] ============================"
"=============================================================================="
set spell                         " turn on spell checking
set spelllang=en_us               " Set spell check to English
hi clear SpellBad                 " highlight misspelled words
hi SpellBad cterm=underline       " set highlight style to underline for misspelled

"=============================================================================="
"================================== [ Folds ] ================================="
"=============================================================================="
set foldmethod=indent             " Fold Based Upon Indent
set foldnestmax=10                " Deepest Fold Allowed Is 10 Levels
set nofoldenable                  " Don't Fold by Default
set foldlevel=1                   " Allow Folding At One Line

"=============================================================================="
"=============================== [ Indentation ] =============================="
"=============================================================================="
set autoindent                    " Copy indent from current line when starting a new line
filetype plugin indent on
set tabstop=2                     " Sane tab stops
set shiftwidth=2
set expandtab                     " Use spaces instead of tabs

" set showtabline=1                 " Show tab line when > 1 tab open
" Python double space tab
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4

set iskeyword-=:                 " make colon a word separator
"autocmd FileType cpp set iskeyword-=:
