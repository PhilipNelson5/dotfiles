" Plugins
" If this is the first time you are using vim-plug on this machine
" it will create the required file structure
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

  "Plug 'PotatoesMaster/i3-vim-syntax'
  "Plug 'iCyMind/NeoSolarized'
  Plug 'PotatoesMaster/i3-vim-syntax'
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --js-completer --rust-completer --enable-coverage' }
  Plug 'ericcurtin/CurtineIncSw.vim'
  Plug 'jelera/vim-javascript-syntax'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'octol/vim-cpp-enhanced-highlight'
  Plug 'othree/html5.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
  Plug 'rhysd/vim-clang-format'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'tikhomirov/vim-glsl'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-scripts/a.vim'

call plug#end()

" Header Source toggle
" --------------------
"map <F4> :call CurtineIncSw()<CR>

" NeoSolarized
" ------------
"colorscheme NeoSolarized
"set background=dark
"let g:neosolarized_bold = 1
"let g:neosolarized_underline = 1
"let g:neosolarized_italic = 1
"let g:neosolarized_vertSplitBgTrans = 0
"let g:neosolarized_contrast = "high"

" Octol C++ Enhanced Highlight
" ----------------------------
let g:cpp_class_scope_highlight = 1

" Clang-Format
" ------------
let g:clang_format#auto_format=0
let g:clang_format#auto_format_on_insert_leave=0
let g:clang_format#detect_style_file=1
let g:clang_format#auto_formatexpr=1

autocmd Filetype cpp,hpp map <leader>f <Esc>:ClangFormat<CR>

" NERD Commenter
" --------------
filetype plugin on
inoremap <C-_> <C-o>:call NERDComment(0,"toggle")<CR>
vnoremap <C-_> :call NERDComment(0,"toggle")<CR>
nnoremap <C-_> :call NERDComment(0,"toggle")<CR>

" NERD Tree
" ---------
" close vim if nerdtree is the only thing still open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-glsl
" --------
autocmd! BufNewFile,BufRead *.vs,*.fs,*.frag,*.vert set ft=glsl

" You Complete Me
" ---------------
let g:ycm_extra_conf_globlist = ['~/*']

" a.vim
nnoremap <F4> :up<CR>:A<CR>
nnoremap <F5> :up<CR>:AV<CR>
