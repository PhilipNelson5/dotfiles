" Live update your init.vim when you modify it ! ! !
augroup reload_vimrc
autocmd!
autocmd BufWritePost init.vim source $MYVIMRC
autocmd BufWritePost general.vimrc source $MYVIMRC
autocmd BufWritePost keys.vimrc source $MYVIMRC
autocmd BufWritePost plugins.vimrc source $MYVIMRC
augroup END

" Turn on the mouse
set mouse=a

" Keep the block cursor always
set guicursor=

" Relative line numbers
set relativenumber

" More natural splits
set splitright
set splitbelow

" Tabs and Spaces
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent      " automatically detect indentation
set copyindent      " copy indent from the previous line

" Spell checking
set spell                         " turn on spell checking
set spelllang=en_us               " Set spell check to English
hi clear SpellBad                 " highlight misspelled words
hi SpellBad cterm=underline       " set highlight style to underline for misspelled

" ignore case unless there are uppercase characters in the search 
set ignorecase
set smartcase

" Clipboard
set clipboard+=unnamedplus

" settings for netrw file explorer
let g:netrw_banner = 1
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

" Use ag instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  let $FZF_DEFAULT_COMMAND='ag --nocolor --ignore node_modules -g ""'
endif
