" Plugins
" If this is the first time you are using vim-plug on this machine
" it will create the required file structure
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

  Plug 'iCyMind/NeoSolarized'
  Plug 'jelera/vim-javascript-syntax'
  Plug 'octol/vim-cpp-enhanced-highlight'
  Plug 'rhysd/vim-clang-format'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tikhomirov/vim-glsl'
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang --system-boost --js-completer' }

call plug#end()

" NeoSolarized
colorscheme NeoSolarized
set background=dark
let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 1
let g:neosolarized_vertSplitBgTrans = 0
let g:neosolarized_contrast = "high"

" Octol C++ Enhanced Highlight
let g:cpp_class_scope_highlight = 1

" Clang-Format
let g:clang_format#auto_format=0
let g:clang_format#auto_format_on_insert_leave=0
let g:clang_format#detect_style_file=1
let g:clang_format#auto_formatexpr=1

autocmd Filetype cpp,hpp map <leader>f <Esc>:ClangFormat<CR>

" NERD Commenter
filetype plugin on

" vim-glsl
autocmd! BufNewFile,BufRead *.vs,*.fs,*.frag,*.vert set ft=glsl
