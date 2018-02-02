"=============================================================================="
"============================= [ Custom Key Maps ] ============================"
"=============================================================================="

map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Tabs and buffer maipulation
nnoremap <leader>n :tabnew<CR>         " Open a new empty tab
nnoremap <Leader>l :tabnext<CR>        " Move to the next tab
nnoremap <Leader>h :tabprevious<CR>    " Move to the previous tab
nnoremap <Leader>bq :bp <BAR> bd #<CR> " Close the current tab and move to the previous one
nnoremap <Leader>bl :ls<CR>            " Show all open buffers and their status
nnoremap <F10> :bn<CR>                 " Next buffer
nnoremap <S-F10> :bp<CR>               " Previuous buffer

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

" Normal moving over wrapped lines
" nnoremap j gj
" nnoremap k gk

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

" Fold function name and body
nnoremap <leader>fo v/{<CR>%zf:nohl<CR>

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

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

"=============================================================================="
"============================ [ File Type Specific ] =========================="
"=============================================================================="

"Java Script
autocmd FileType javascript nmap <F3> <ESC>:w<CR> :!node '%:t'<CR>
autocmd FileType javascript imap <F3> <ESC>:w<CR> :!node '%:t'<CR>

" LaTex
autocmd FileType tex nmap <F3> <ESC>:w<CR> :!latex '%:t'<CR>
autocmd FileType tex imap <F3> <ESC>:w<CR> :!latex '%:t'<CR>

" R Markdown
autocmd Filetype rmd nmap <F3> <ESC>:!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
autocmd Filetype rmd imap <F3> <ESC>:!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>

" Python
autocmd FileType python nmap <F3> <ESC>:w<CR> :!python2 '%:t'<CR>
autocmd FileType python imap <F3> <ESC>:w<CR> :!python2 '%:t'<CR>

" C++
autocmd Filetype cpp,hpp nmap <F3> <ESC>:wa<CR> :make -j<CR>
autocmd Filetype cpp,hpp imap <F3> <ESC>:wa<CR> :make -j<CR>

autocmd Filetype cpp,hpp nmap <S-F3> <ESC>:wa<CR> :make debug -j<CR>
autocmd Filetype cpp,hpp imap <S-F3> <ESC>:wa<CR> :make debug -j<CR>

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
inoremap <expr> j ((pumvisible())?("\<C-n>"):("gj"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("gk"))
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

