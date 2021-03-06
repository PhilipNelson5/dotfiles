" Welcome to my VIM configuration! This has been a work in progress
" since the summer of 2016 when I started my journey to learn VIM.
" I have learned a lot by reading other peoples' vimrcs and I hope
" you can learn something from mine! Happy vimming!

"===================================================================="
"============================= [ Notes ] ============================"
"===================================================================="
" Here are some useful things I have learned whilst building my vimrc
"
" * Put your vimrc on git hub or some sort of source control! There will be a
" point when you screw up and will need to revert. That's ok, it's all safely
" stowed away.
"
" * If you want to reset a key to it's default mapping, put unmap <key> and
" reload your vimrc
"
" * If you have broken something and can not figure it out, try:
" vim -V20 2>&1 | tee logfile
" This will save a log of vim's loading output and this can help you locate
" the source of your issue

"===================================================================="
"=========================== [ Beginning ] =========================="
"===================================================================="

" for the current millennium
" tells vim that it doesn't have to act like vi anymore
set nocompatible

" Set leader to space
let mapleader="\<Space>"

" reload .vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>

" easy access to edit .vimrc
noremap <F12>  <Esc>:tabnew $MYVIMRC<CR>

" Live update on write of your vimrc!!!
augroup reload_vimrc
autocmd!
autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

"-===================================================================="
"========================== [ The Basics ] =========================="
"===================================================================="
set ruler               " Turns the ruler on
set number              " Line numbers
set rnu                 " use relative line numbers
set numberwidth=4       " Width of the gutter
set shortmess=atI       " No help Uganda information
set incsearch           " Find as you type search
set hlsearch            " No highlight search terms
set ignorecase          " Case in-sensitive search
set smartcase           " Case sensitive when uc present
set autoread            " Automatically read a file changed outside of vim
set autowrite           " Automatically write a file when leaving a modified buffer
set hidden              " Allow buffer switching without saving
set showcmd             " Show partial commands on the status line and Selected characters/lines in visual mode
set showmode            " Display current mode
"set showmatch           " Show the matching bracket/brace/parenthesis
set matchtime=5         " Show matching time
set laststatus=2        " Always show status line
filetype plugin indent on      " Automatically detect file types
set linespace=0                " No extra spaces between rows
set backspace=indent,eol,start " Backspace for dummies
set backupdir=~/.vim/backup    " Set the backup directory
set directory=~/.vim/swap      " Set the swap files directory
"nnoremap <F1> <nop>            " Turn off F1 key
set ttyfast                    " Improved performance
set lazyredraw                 " Only redraw when needed (better for large macros)

set laststatus=2
set ttimeoutlen=50
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

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
  set undodir=~/.vim/undo/       " Set undo file directory
  set undofile                   " Persistent undo on
  set undolevels=1000            " Maximum number of changes that can be undone
  set undoreload=10000           " Maximum number lines to save for undo on a buffer reload
endif

set pastetoggle=<F1>          " Toggle paste mode

"===================================================================="
"======================= [ Mouse / Scrolling ] ======================"
"===================================================================="
set mouse=a                    " Enable mouse usage
set mousehide                  " Hide the mouse cursor while typing

"===================================================================="
"========================= [ Spell Checking ] ======================="
"===================================================================="
set spell spelllang=en_us      " Set spell check to English
hi clear SpellBad              " highlight misspelled words
hi SpellBad cterm=underline    " set highlight style to underline for misspelled

" z=                           " change misspelled word
" ]s                           " go to next misspelled word
" [s                           " go to previous misspelled word

"===================================================================="
"============================= [ Folds ] ============================"
"===================================================================="
"set foldcolumn=1               "
"set foldmethod=indent
"autocmd FileType html set foldmethod=manual
"set foldnestmax=10             " Deepest fold allowed is 10 levels
"set foldlevel=1                " Allow folding at one line
"set nofoldenable               " Do not fold by default

" automatically save and load folds
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

"===================================================================="
"======================== [ Tabs / Buffers ] ========================"
"===================================================================="
set autoindent                         " Copy indent from current line when starting a new line
filetype plugin indent on
set tabstop=2                          " Number of spaces that a <Tab> in the file counts for
set softtabstop=2
set shiftwidth=2                       " Number of spaces to use for each step of (auto)indent
set expandtab                          " Use spaces in place of tabs

set showtabline=1                      " Show tab line when > 1 tab open
nnoremap <leader>n :tabnew<CR>         " Open a new empty tab
nnoremap <Leader>l :tabnext<CR>        " Move to the next tab
nnoremap <Leader>h :tabprevious<CR>    " Move to the previous tab
nnoremap <Leader>bq :bp <BAR> bd #<CR> " Close the current tab and move to the previous one
nnoremap <Leader>bl :ls<CR>            " Show all open buffers and their status
nnoremap <F10> :bn<CR>                 " Next buffer
nnoremap <C-F10> :bp<CR>               " Previuous buffer

"===================================================================="
"========================== [ Custom Maps ] ========================="
"===================================================================="

"draw line at the 81st column
let &colorcolumn=join(range(82,999),",")
let &colorcolumn="81,".join(range(400,999),",")
" Remove trailing white space
nnoremap <Leader>s mz:%s/\s\+$//<Enter>'zzz

" Save
nnoremap <Leader>w :w<CR>

" Save As
nnoremap <Leader>W :w<Space>

" Write All
nnoremap <Leader>a :wa<CR>

" Write Quit All
nnoremap <Leader>A :wqa<CR>

" Quit
nnoremap <Leader>q :q<CR>

" Force Quit
nnoremap <Leader>Q :q!<CR>

" Edit File
nnoremap <Leader>e :e<Space>

" Save with ctrl-c
inoremap <C-C> <ESC>:w<CR>
nnoremap <C-C> :w<CR>

" Comment out a line
"nnoremap <Leader>c I/* <ESC>A */<ESC>
"nnoremap <Leader>C 0xxx$xxx

" Generate cout from comment
nnoremap <Leader>o ^cf<Space>std::cout << <esc>A << std::endl;<esc>:nohl<CR>

" Turn cout into comment
nnoremap <Leader>O 0vf<;c//<esc>$vF<;dx

" Clear Highlighting
nnoremap <Leader>d :nohl<CR>

" Normal moving over wrapped lines
nnoremap j gj
nnoremap k gk

" Shift-j/k scrolls the screen and centers the cursor
nnoremap J gjzz
nnoremap K gkzz

" Visual shifting without needing to use shift and it does not exit Visual mode
vnoremap . >gv
vnoremap , <gv

" gg & G mark their location with the j register
nnoremap gg mjgg
nnoremap G mjG

" Center the screen after jumping to a mark
nnoremap <expr> ' printf('`%c zz',getchar())

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Center the screen when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Easier to type, and I never use the default behavior
noremap H ^
noremap L g_

" Auto curly braces
inoremap <F2> {<Esc>o}<Esc>O

" Auto capitalize WORD
inoremap <C-u> <esc>mzgUiw`za

" change in between tags
nnoremap ci< F>lct<

" Helps 'COPE' with your problems
noremap <F4> :cp<CR>zz
noremap <F5> :cn<CR>zz

" For compiling c++
nnoremap <F3> :wa<CR> :make -j<CR>
inoremap <F3> <ESC>:wa<CR> :make -j<CR>
vnoremap <F3> <ESC>:wa<CR> :make -j<CR>

" Searches for all instances of TODO and FIXME
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

" automatically adds the correct shebang to script files
augroup Shebang
  autocmd BufNewFile *.sh 0put =\"#!/usr/bin/env bash\<nl>\"|$
  autocmd BufNewFile *.ps 0put =\"%!PS\<nl>\"|$
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\"|$
  autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl>\"|$
  autocmd BufNewFile *.\(cc\|hh\) 0put =\"//\<nl>// \".expand(\"<afile>:t\").\" -- \<nl>//\<nl>\"|2|start!
augroup END

nnoremap tt <S-y>pa/<ESC>O
"===================================================================="
"============================ [ Windows ] ==========================="
"===================================================================="

" resize window
" 5px
nnoremap <silent> <C-Right> :vertical resize +5<CR>
nnoremap <silent> <C-Left> :vertical resize -5<CR>
nnoremap <silent> <C-Up> :resize +5<CR>
nnoremap <silent> <C-Down> :resize -5<CR>
" 1px
nnoremap <silent> <C-S-Right> :vertical resize +1<CR>
nnoremap <silent> <C-S-Left> :vertical resize -1<CR>
nnoremap <silent> <C-S-Up> :resize +1<CR>
nnoremap <silent> <C-S-Down> :resize -1<CR>

"===================================================================="
"============================ [ Buffers ] ==========================="
"===================================================================="
" Show all open buffers and their status
noremap <leader>bl :ls<CR>

" Next buffer
nnoremap <F10> :bn<CR>
nnoremap <C-F10> :bp<CR>

"===================================================================="
"======================== [ Tab Completion ] ========================"
"===================================================================="
"Search into all sub-folders and tab-complete file-related tasks
set path+=**

"settings for wildmenu
set wildmenu
set wildmode=list:longest,full

set wildignore+=*.swp,*.~un,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip
set wildignore+=*/tmp/*,*.o,*.obj,*.so     " Unix
set wildignore+=*\\tmp\\*,*.exe            " Windows

filetype plugin on
set dictionary=/usr/share/dict/words
set complete=.,w,b,u,t,i,d
set completeopt=menu,preview
set omnifunc=syntaxcomplete#Complete

" Enable j & k to work in drop down auto complete lists
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
inoremap <expr> <Tab> ((pumvisible())?("\<C-n>"):(" "))
"inoremap <expr> <Tab> ((pumvisible())?(" "):("\<C-n>"))

" - ^x^n for JUST this file
" - ^x^f for file names (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

"===================================================================="
"======================= [ File Type Specific ] ====================="
"===================================================================="
augroup configgroup
autocmd!
autocmd FileType tex nmap <F3> :w<CR> :!latex '%:t'<CR>
autocmd FileType tex imap <F3> <ESC>:w<CR> :!latex '%:t'<CR>

augroup END

augroup configgroup
autocmd!
autocmd FileType python nmap <F3> :w<CR> :!python2 '%:t'<CR>
autocmd FileType python imap <F3> <ESC>:w<CR> :!python2 '%:t'<CR>

augroup END
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

"===================================================================="
"=========================== [ Vim-Plug ] ==========================="
"======================== [ Plugin Manager ] ========================"
"===================================================================="

" If this is the first time you are using vim-plug on this machine
" it will create the required file structure
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" List of plugins for vim-plug to install
" Format is Plug 'git repo'
call plug#begin('~/.vim/plugged')
"Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dhruvasagar/vim-table-mode'
Plug 'JuliaEditorSupport/julia-vim'
"Plug 'junegunn/goyo.vim'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
"Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-latex/vim-latex'
call plug#end()

"--------------------------------------------------------------------"
"-------------------------- [ git-gutter ] --------------------------"
" Shows a git diff in the 'gutter'.
" It shows whether a line has been added, modified,
" and where lines have been removed
"--------------------------------------------------------------------"
let g:gitgutter_realtime=1      " real time sign updates

"--------------------------------------------------------------------"
"-------------------------- [ Solarized ] ---------------------------"
" The Solarized color scheme for vim
"--------------------------------------------------------------------"
set t_Co=256                  " Allow 256 colors
syntax enable                 " Enable syntax highlighting
let g:solarized_termtrans=1   " Allow Solarized to have a transparent background
let g:solarized_termcolors=16
set background=dark
colorscheme solarized
"call togglebg#map("<F8>") " Toggle light and dark background
au BufRead,BufNewFile .Xresources set filetype=xdefaults

"--------------------------------------------------------------------"
"----------------------------- [ TABLES ] ---------------------------"
"--------------------------------------------------------------------"
noremap <leader>tm :TableModeToggle<CR>
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

"--------------------------------------------------------------------"
"----------------------------- [ TABLES ] ---------------------------"
"--------------------------------------------------------------------"
let g:default_julia_version = "0.6.1"

"--------------------------------------------------------------------"
"----------------------------- [ GOYO ] -----------------------------"
" Distraction-free writing in Vim. Setup to remove all unnecessary
" distractions while writing in markdown
"--------------------------------------------------------------------"

"function! s:auto_goyo()
"if &ft == 'markdown' && winnr('$') == 1
"Goyo 120
"elseif exists('#goyo')
"Goyo!
"endif
"endfunction
"
"function! s:goyo_leave()
"if winnr('$') < 2
"silent! :q
"endif
"endfunction
"
"augroup goyo_markdown
"autocmd!
"autocmd	BufNewFile,BufRead * call	s:auto_goyo()
"autocmd! User	GoyoLeave	nested call	s:goyo_leave()
"augroup END

"--------------------------------------------------------------------"
"--------------------------- [ Tag Bar ] ----------------------------"
" Provides an easy way to browse the tags of the current file
" and get an overview of its structure.
"--------------------------------------------------------------------"

noremap <F8> :TagbarToggle<CR>

"--------------------------------------------------------------------"
"-------------------------- [ Undo Tree ] ---------------------------"
" Visitation of the vim undo tree
"--------------------------------------------------------------------"

nnoremap <C-u> :UndotreeToggle<cr>

"--------------------------------------------------------------------"
"---------------------------- [ Octol ] -----------------------------"
" Additional Vim syntax highlighting for C++
"--------------------------------------------------------------------"

let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

"--------------------------------------------------------------------"
"------------------------ [ clang-format ] --------------------------"
" Formats your code with specific coding style using clang-format.
"--------------------------------------------------------------------"

let g:clang_format#auto_format=0
let g:clang_format#auto_format_on_insert_leave=0
let g:clang_format#detect_style_file=1
let g:clang_format#auto_formatexpr=1

nnoremap <C-f> :ClangFormat<CR>zz
vnoremap <C-f> :ClangFormat<CR>zz
inoremap <C-f> <Esc>:ClangFormat<CR>zz

"--------------------------------------------------------------------"
"------------------------- [ NERD Comment ] -------------------------"
" Comment functions so powerful — no comment necessary
"--------------------------------------------------------------------"
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

"--------------------------------------------------------------------"
"-------------------------- [ NERD Tree ] ---------------------------"
" The NERD tree allows you to explore your file system
" and open files and directories
"--------------------------------------------------------------------"

nnoremap <Leader>f :NERDTreeToggle<CR> " toggle NERDTree with C-n

" closes NERDTree if it is the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" open NERDTree if no file was opened
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"--------------------------------------------------------------------"
"----------------------- [ instant-markdown ] -----------------------"
"When you open a markdown file in vim, a browser window will open which shows
"the compiled markdown in real-time, and closes once you close the file in vim.
"--------------------------------------------------------------------"
" For this to work you will need to do:
" sudo npm -g install instant-markdown-d

"--------------------------------------------------------------------"
"------------------------ [ vim-markdown ] --------------------------"
" Syntax and more for markdown in vim
"--------------------------------------------------------------------"

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_syntax_conceal = 0

"--------------------------------------------------------------------"
"--------------------------- [ Airline ] ----------------------------"
" Lean & mean status/tabline for vim that's light as air
"--------------------------------------------------------------------"

let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#left_sep = ' '
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])

let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

"--------------------------------------------------------------------"
"------------------------- [ Latex-Suite ] --------------------------"
" Provides a rich tool of features for editing latex files
"--------------------------------------------------------------------"

filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
set sw=2
set iskeyword+=:

"--------------------------------------------------------------------"
"------------------------- [ Syntastic ] ----------------------------"
" Syntax checking
"--------------------------------------------------------------------"

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0


"===================================================================="
"=========================== [ Snippets ] ==========================="
"===================================================================="
" nnoremap ,<some command> :-1read $HOME/path/to/file.type<CR><commands to place cursor>

" Pipe console output to scratch buffer
" command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
" function! s:RunShellCommand(cmdline)
" 	let isfirst = 1
" 	let words = []
" 	for word in split(a:cmdline)
" 		if isfirst
" 			let isfirst = 0  " don't change first word (shell command)
" 		else
" 			if word[0] =~ '\v[%#<]'
" 				let word = expand(word)
" 			endif
" 			let word = shellescape(word, 1)
" 		endif
" 		call add(words, word)
" 	endfor
" 	let expanded_cmdline = join(words)
" 	botright new
" 	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
" 	call setline(1, 'You entered:  ' . a:cmdline)
" 	call setline(2, 'Expanded to:  ' . expanded_cmdline)
" 	call append(line('$'), substitute(getline(2), '.', '=', 'g'))
" 	silent execute '$read !'. expanded_cmdline
" 	1
" endfunction
