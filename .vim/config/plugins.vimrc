"=============================================================================="
"================================ [ Vim-Plug ] ================================"
"============================= [ Plugin Manager ] ============================="
"=============================================================================="

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
"Plug 'junegunn/goyo.vim'
"Plug 'suan/vim-instant-markdown'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'Valloric/YouCompleteMe'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dhruvasagar/vim-table-mode'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'pangloss/vim-javascript'
Plug 'rhysd/vim-clang-format'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
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
"----------------------- [ You-Complete-Me ] ------------------------"
" Amazing syntax aware completion
"--------------------------------------------------------------------"
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_python_binary_path = '/usr/bin/python3'

"--------------------------------------------------------------------"
"-------------------------- [ Solarized ] ---------------------------"
" The Solarized color scheme for vim
"--------------------------------------------------------------------"
let g:solarized_termtrans=1    " Allow Solarized to have a transparent background
let g:solarized_termcolors=16  " I think these colors look better

" Need to source the toggle plugin
source $HOME/.vim/plugged/vim-colors-solarized/autoload/togglebg.vim
call togglebg#map("<F8>") " Toggle light and dark background
au BufRead,BufNewFile .Xresources set filetype=xdefaults

"--------------------------------------------------------------------"
"----------------------------- [ TABLES ] ---------------------------"
"--------------------------------------------------------------------"
noremap <leader>tm :TableModeToggle<CR>
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

"--------------------------------------------------------------------"
"------------------------------ [ Julia ] ---------------------------"
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

autocmd Filetype cpp,hpp nmap <C-f> :ClangFormat<CR>zz
autocmd Filetype cpp,hpp vmap <C-f> :ClangFormat<CR>zz
autocmd Filetype cpp,hpp imap <C-f> <Esc>:ClangFormat<CR>zz

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

nnoremap <Leader>o :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = 'v'

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" closes NERDTree if it is the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" open NERDTree if no file was opened
" (I found this annoying but you might like it)
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"--------------------------------------------------------------------"
"----------------------- [ instant-markdown ] -----------------------"
"When you open a markdown file in vim, a browser window will open which shows
"the compiled markdown in real-time, and closes once you close the file in vim.
"--------------------------------------------------------------------"
" For this to work you will need to do:
" sudo npm -g install instant-markdown-d

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

set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
set sw=2
set iskeyword+=:

"--------------------------------------------------------------------"
"------------------------- [ Syntastic ] ----------------------------"
" Syntax checking
"--------------------------------------------------------------------"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers=['eslint']
