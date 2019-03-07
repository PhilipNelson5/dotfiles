" Space Leader
let mapleader="\<SPACE>"

" reload .vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>

" easy access to edit .vimrc, changes the local dir to config folder
noremap <F12>  <Esc>:tabnew $MYVIMRC<CR>:lcd $HOME/.config/nvim/config<CR>

" Auto curly braces
inoremap <F2> {<Esc>o}<Esc>O

" Generic indentation formatting
noremap <F7> <Esc>mzgg=G`zzz

" Remove trailing white space
nnoremap <Leader>s mz:%s/\s\+$//<Enter>'zzz

" Toggle line wrapping
nnoremap <leader>sw :set wrap!<CR>

" Normal movement on wrapped lines
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Turn off highlighting
nnoremap <leader>d :nohl<CR>

" Quick writing
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w<Space>
nnoremap <leader>a :wa<CR>

" Quick file edit
"   run fzf
nnoremap <Leader>e :up<CR>:FZF<CR>

" Quick quitting
nnoremap <leader>q :q<CR>

" Quick compiling
nnoremap <leader>m :wa<CR>:make<CR>

" Quick compiling in build directory
nnoremap <leader>M :wa<CR>:make -j --directory=build --no-print-directory<CR>

" Quick execute
nnoremap <leader>r :!make run<CR>

" Open a new tab
nnoremap <leader>n :tabnew<CR>

" Correct misspelled word to first suggestion
nnoremap <Leader>z z=1<CR><CR>

" Move to the beginning and end of a line
noremap L $
noremap H ^

" Go the Top, Middle, or Bottom of the screen
nnoremap gt H
nnoremap gm M
nnoremap gb L

" Centered movement
nnoremap J jzz
nnoremap K kzz

" Simple movement to different splits
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Move to the next and previous tab
nnoremap <leader>l :tabn<CR>
nnoremap <leader>h :tabp<CR>

nnoremap <leader>o :NERDTreeToggle<CR>

" change in between and around $ $
nnoremap ci$ F$lct$
nnoremap ca$ F$cf$

" delete in between and around $ $
nnoremap di$ F$ldt$
nnoremap da$ F$df$

" visual select in between and around $ $
nnoremap vi$ F$lvt$
nnoremap va$ F$vf$

" yank in between and around $ $
nnoremap yi$ F$lyt$
nnoremap ya$ F$yf$

"auto begin( ), end( ) for std::algorithms
nnoremap <Leader>be ciwstd::begin(<ESC>pa), std::end(<ESC>pa),

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" [F]ind [U]sage of word under cursor
command! FU grep -R <cword> .

" For You Complete Me
" Fix It
nnoremap <leader>yf :YcmCompleter FixIt<CR>

"=============================================================================="
"============================ [ File Type Specific ] =========================="
"=============================================================================="

" generate header file include guards
autocmd Filetype cpp,hpp map <leader>g V:s/ /_/g<CR>V~"ad$i#ifndef <ESC>"apa_HPP<CR>#define <ESC>"apa_HPP<ESC>mmGo<CR>#endif<ESC>'mj:nohl<CR>

" LaTex
autocmd FileType tex imap <F3> <ESC>:w<CR> :!pdflatex '%:t'<CR>
autocmd FileType tex map <F3> <ESC>:w<CR> :!pdflatex '%:t'<CR>

" Markdown
autocmd FileType markdown map <leader>m :wa<CR>:!pan '%:t'<CR>

" Java Script
autocmd FileType javascript noremap <leader>f :w<CR>:!eslint --fix '%:p'<CR>

" automatically adds the correct shebang to script files
augroup Shebang
  autocmd BufNewFile *.sh 0put =\"#!/usr/bin/env bash\<nl>\"|$
  autocmd BufNewFile *.ps 0put =\"%!PS\<nl>\"|$
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\"|$
  autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl>\"|$
  autocmd BufNewFile *.\(cc\|hh\) 0put =\"//\<nl>// \".expand(\"<afile>:t\").\" -- \<nl>//\<nl>\"|2|start!
augroup END
