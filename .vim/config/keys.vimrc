"=============================================================================="
"============================ [ Custom Key Maps ] ============================="
"=============================================================================="
augroup vimrc
    au!
    au VimEnter * unmap <C-j>
    au VimEnter * noremap <C-j> <C-w>j
augroup END

" easy access to edit .vimrc, changes the local dir to config folder
noremap <F12>  <Esc>:tabnew $MYVIMRC<CR>:lcd $HOME/.vim/config<CR>

map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Tabs and buffer manipulation
nnoremap <leader>n :tabnew<CR>         " Open a new empty tab
nnoremap <leader>l :tabnext<CR>        " Move to the next tab
nnoremap <leader>h :tabprevious<CR>    " Move to the previous tab
nnoremap <leader>bq :bp <BAR> bd #<CR> " Close the current tab and move to the previous one
nnoremap <leader>bl :ls<CR>            " Show all open buffers and their status
nnoremap <F10> :bn<CR>                 " Next buffer
nnoremap <S-F10> :bp<CR>               " Previuous buffer
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>

" usually the first spellcheck options is correct
" choose the first spellcheck option
nnoremap <Leader>z z=1<CR><CR>

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

" Clear Highlighting
nnoremap <Leader>d :nohl<CR>

" Open COPE
nnoremap <Leader>co :cope<CR>

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
nnoremap <expr> ' printf('`%czz',getchar())

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Center the screen when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Easier to type, and I never use the default behavior
noremap H ^
noremap L $

" Auto curly braces
inoremap <F2> {<Esc>o}<Esc>O

" Fold function name and body
nnoremap <leader>fo v/{<CR>%zf:nohl<CR>cw

" Auto capitalize WORD
inoremap <C-u> <esc>mzgUiw`za

" complete tag
inoremap <C-t>a <ESC>vBy$pbi/<Esc>ba
inoremap <C-t>o <ESC>Ypa/<ESC>O

" change in between tags
nnoremap ci< F>lct<

" Helps 'COPE' with your problems
noremap <F4> :cp<CR>zz
noremap <F5> :cn<CR>zz

" Searches for all instances of TODO and FIXME
command! Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw

" Generic auto fix indentation
nnoremap <F7> mzgg=G`zzz
inoremap <F7> <Esc>mzgg=G`zzza

" Sort highlighted lines
noremap S :sort<CR>

" Turn off Ex Mode
nnoremap Q <nop>

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" You Complete Me
" FixIt
nnoremap <Leader>yf :YcmCompleter FixIt<CR>

" jump to the next <++> mark, usually <C-j>
nnoremap <Leader>m /<++><CR>:nohl<CR>cw

"auto for loop generator :D
nnoremap <Leader>fl ^yiwifor(auto <ESC>f i =<ESC>2f i; <ESC>p3f i;<ESC>$pa)<ESC>

"auto for each generator :D :D
nnoremap <Leader>fe Ifor (auto&& <ESC>f i :<ESC>A)<ESC>

"=============================================================================="
"============================ [ File Type Specific ] =========================="
"=============================================================================="

"Java Script
autocmd FileType javascript nmap <F3> :wa<CR> :!node '%:t'<CR>
autocmd FileType javascript imap <F3> <ESC>:wa<CR> :!node '%:t'<CR>

autocmd FileType javascript noremap <C-F> <ESC>:w<CR>:!eslint --fix '%:p'<CR>:redraw<CR>

" autocmd FileType javascript nmap <C-F> :w<CR>:!clang-format -i -style=file '%:t'<CR>:redraw<CR>
" autocmd FileType javascript imap <C-F> <ESC>:w<CR>:!clang-format -i -style=file '%:t'<CR>:redraw<CR>

" LaTex
autocmd FileType tex nmap <F3> <ESC>:w<CR> :!pdflatex '%:t'<CR>:redraw<CR>
autocmd FileType tex imap <F3> <ESC>:w<CR> :!pdflatex '%:t'<CR>:redraw<CR>

" R Markdown
autocmd Filetype rmd nmap <F3> <ESC>:!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
autocmd Filetype rmd imap <F3> <ESC>:!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>

" Python
autocmd FileType python nmap <F3> :w<CR> :!python3 '%:t'<CR>
autocmd FileType python imap <F3> <ESC>:w<CR> :!python3 '%:t'<CR>

" C++
autocmd Filetype cpp,hpp nmap <F3> <ESC>:wa<CR> :make -j<CR>:redraw<CR>
autocmd Filetype cpp,hpp imap <F3> <ESC>:wa<CR> :make -j<CR>:redraw<CR>

autocmd Filetype cpp,hpp nmap <S-F3> <ESC>:wa<CR> :make debug -j<CR>:redraw<CR>
autocmd Filetype cpp,hpp imap <S-F3> <ESC>:wa<CR> :make debug -j<CR>:redraw<CR>

" generate header file include guards
autocmd Filetype cpp,hpp map <leader>g V~"ad$i#ifndef <ESC>"apa_HPP<CR>#define <ESC>"apa_HPP<CR><CR><CR>#endif<ESC>kO

"=============================================================================="
"============================= [ Tab Completion ] ============================="
"=============================================================================="
"Search into all sub-folders and tab-complete file-related tasks
"set path+=**

"settings for wildmenu
"set wildmenu
"set wildmode=list:longest,full

set wildignore+=*.swp,*.~un,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip
set wildignore+=*/tmp/*,*.o,*.obj,*.so,*.out     " Unix
set wildignore+=*\\tmp\\*,*.exe                  " Windows

"set dictionary=/usr/share/dict/words
"set complete=.,w,b,u,t,i,d
"set completeopt=menu,preview
"set omnifunc=syntaxcomplete#Complete

" Enable j & k to work in drop down auto complete lists
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
inoremap <expr> <Tab> ((pumvisible())?("\<C-n>"):(" "))

" - ^x^n for JUST this file
" - ^x^f for file names (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-P>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
